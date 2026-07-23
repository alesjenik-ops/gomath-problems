String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD22C0T02';
Integer YEAR = 2022;

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
  'CERMAT M7B 2022 – úloha 6',
  new List<String>{'Tabulka udává některé údaje o loňském a letošním prodeji pšenice a ječmene.','6.1 Letos se prodalo o polovinu méně pšenice než loni. Vypočtěte, kolik tun pšenice se prodalo letos.','6.2 Loni se prodalo o polovinu více ječmene než letos. Vypočtěte, kolik tun ječmene se prodalo letos.','6.3 Tuna pšenice byla i loni dražší než tuna ječmene. Jejich loňské ceny byly v poměru $4:3$. Vypočtěte, za kolik Kč se loni prodávala tuna pšenice.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 510 172" font-family="sans-serif" font-size="13"> <rect x="10" y="10" width="488" height="150" fill="none" stroke="#000"/> <line x1="106" y1="10" x2="106" y2="160" stroke="#000"/> <line x1="302" y1="10" x2="302" y2="160" stroke="#000"/> <line x1="204" y1="44" x2="204" y2="160" stroke="#000"/> <line x1="400" y1="44" x2="400" y2="160" stroke="#000"/> <line x1="106" y1="44" x2="498" y2="44" stroke="#000"/> <line x1="10" y1="92" x2="498" y2="92" stroke="#000"/> <line x1="10" y1="126" x2="498" y2="126" stroke="#000"/> <text x="204" y="32" text-anchor="middle">Loni</text> <text x="400" y="32" text-anchor="middle">Letos</text> <text x="155" y="64" text-anchor="middle">hmotnost</text> <text x="155" y="80" text-anchor="middle">v tunách</text> <text x="253" y="64" text-anchor="middle">cena v Kč</text> <text x="253" y="80" text-anchor="middle">za tunu</text> <text x="351" y="64" text-anchor="middle">hmotnost</text> <text x="351" y="80" text-anchor="middle">v tunách</text> <text x="449" y="64" text-anchor="middle">cena v Kč</text> <text x="449" y="80" text-anchor="middle">za tunu</text> <text x="16" y="112">Pšenice</text> <text x="155" y="112" text-anchor="middle">200</text> <text x="449" y="112" text-anchor="middle">5 800</text> <text x="16" y="146">Ječmen</text> <text x="155" y="146" text-anchor="middle">90</text> <text x="253" y="146" text-anchor="middle">4 200</text> <text x="449" y="146" text-anchor="middle">4 800</text> </svg>',
  'tabulka-obili.svg',
  'Tabulka prodeje pšenice a ječmene loni a letos: loni pšenice 200 tun, ječmen 90 tun za 4 200 Kč; letos pšenice 5 800 Kč za tunu, ječmen 4 800 Kč za tunu.',
  'Prodej pšenice a ječmene (loni a letos)',
  new List<String>{'6.1 Loni $200$ tun pšenice, letos o polovinu méně: $200-100=100$ tun.','6.2 Letos $x$ tun ječmene, loni o polovinu více: $1{,}5x=90$, tedy $x=60$ tun.','6.3 Loňské ceny pšenice a ječmene v poměru $4:3$; ječmen $4200$ Kč, pšenice $\\frac{4}{3}\\cdot4200=5600$ Kč za tunu.'},
  '6.1: $100$ tun; 6.2: $60$ tun; 6.3: $5\\,600$ Kč',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
