String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený G15 – přiřazování (slovní úlohy)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V krabici, do které se vejde nejvýše $30$ kuliček, jsou kuličky dvou barev. Modrých je o dvě více než červených. Polovina modrých kuliček je provrtaná, pětina červených je označena bílou barvou. Kolik je v krabici kuliček?','15.2 Ještě v listopadu stál kolobřich $162$ korun, před Vánocemi však podražil o třetinu. Nyní, v lednu, koukám, že zase o třetinu zlevnil. Kolik korun je rozdíl mezi listopadovou a lednovou cenou kolobřichu?','15.3 Do vedlejší devítky chodí o desetinu více žáků než do naší. V naší třídě ale třetina žáků propadá z matiky. Kolik žáků je v naší třídě, jestliže víme, že největší třída může mít podle zákona $33$ žáků?'},
  new List<String>{'A) $0$','B) $10$','C) $18$','D) $25$','E) $30$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Červených $c$, modrých $c+2$. Polovina modrých je celé číslo $\\Rightarrow c$ sudé; pětina červených celé $\\Rightarrow c$ dělitelné $5$; navíc $2c+2\\le 30$. Vyhovuje $c=10$, celkem $2\\cdot 10+2=22$ kuliček. To v nabídce není → F.','15.2 Před Vánocemi $162\\cdot\\frac{4}{3}=216$ Kč, v lednu $216\\cdot\\frac{2}{3}=144$ Kč. Rozdíl $162-144=18$ Kč → C.','15.3 Naše třída $n$: třetina propadá $\\Rightarrow n$ dělitelné $3$; vedlejší $\\frac{11}{10}n$ celé a nejvýše $33 \\Rightarrow n$ dělitelné $10$ a $n\\le 30$. Tedy $n=30$ (vedlejší $33$) → E.'},
  '15.1: F (jiný výsledek, $22$); 15.2: C ($18$); 15.3: E ($30$)',
  6, 10, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
