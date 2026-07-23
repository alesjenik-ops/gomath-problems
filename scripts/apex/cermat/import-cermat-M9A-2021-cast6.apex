String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD21C0T01';
Integer YEAR = 2021;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M9A 2021 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Při úklidové akci „Čisté břehy“ měl každý dobrovolník naplnit jeden odpadkový pytel, ale $20\\,\\%$ dobrovolníků naplnilo ještě druhý pytel. Dobrovolníci tak naplnili o $130$ pytlů více, než se předpokládalo. Kolik pytlů celkem dobrovolníci naplnili?','15.2 Učitel matematiky obdržel peněžitý dar na nákup učebních pomůcek. Za $24\\,\\%$ daru zakoupil $3$ stejná kružítka na tabuli. Model tělesa stál $180$ korun, což představuje $2\\,\\%$ daru. Kolik korun stálo jedno kružítko?','15.3 Na $25\\,\\%$ rozlohy zemědělské půdy Jablonecka jsou pole, zbytek tvoří louky. Pastviny pro dobytek zabírají $20\\,\\%$ rozlohy luk, zbývajících $1\\,800$ hektarů luk se využívá pro pěstování trávy na seno. Kolik hektarů zabírají pole na Jablonecku?'},
  new List<String>{'A) $650$','B) $675$','C) $720$','D) $750$','E) $780$','F) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Druhý pytel naplnilo $20\\,\\%$ dobrovolníků a to je oněch $130$ pytlů navíc, tedy $0{,}2\\cdot D=130$, $D=650$ dobrovolníků. Celkem naplnili $650+130=780$ pytlů → E.','15.2 $2\\,\\%$ daru $=180$ Kč, tedy $1\\,\\%=90$ Kč a celý dar $=9\\,000$ Kč. Za $3$ kružítka utratil $24\\,\\%=2\\,160$ Kč, jedno stojí $2\\,160:3=720$ Kč → C.','15.3 Seno tvoří $80\\,\\%$ luk: $0{,}8\\cdot L=1\\,800$, $L=2\\,250$ ha. Louky jsou $75\\,\\%$ půdy, tedy celá půda $=2\\,250:0{,}75=3\\,000$ ha. Pole $=25\\,\\%$ z $3\\,000=750$ ha → D.'},
  '15.1: E ($780$); 15.2: C ($720$); 15.3: D ($750$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
