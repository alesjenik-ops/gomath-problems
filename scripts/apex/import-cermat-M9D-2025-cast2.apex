String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. náhradní termín (M9D)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2025 M9D · úloha 7',
  new List<String>{'Do soutěže se přihlásilo $10$ soutěžících, všichni psali $1.$ i $2.$ kolo. V každém kole získal každý $8$, $9$, nebo $10$ bodů. V $1.$ kole získalo $9$ bodů $5$ soutěžících; ve $2.$ kole byl aritmetický průměr $9{,}5$ bodu.','7.1 V $1.$ kole bylo soutěžících s $8$ body o jednoho méně než těch s $10$ body. Určete průměrný bodový zisk všech soutěžících v $1.$ kole.','7.2 Určete, kolik soutěžících mohlo ve $2.$ kole získat $9$ bodů. Najděte všechna řešení.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: nechť je $t$ soutěžících s $10$ body, $t-1$ s $8$ body; $(t-1)+5+t=10\\Rightarrow t=3$. Průměr $\\frac{8\\cdot2+9\\cdot5+10\\cdot3}{10}=9{,}1$ bodu.','7.2: $a$ s $8$, $b$ s $9$, $c$ s $10$ body: $a+b+c=10$, $8a+9b+10c=95$; odtud $b+2c=15$, $a=c-5$; pro $c\\in\\{5,6,7\\}$ vychází $b\\in\\{5,3,1\\}$.'},
  '7.1: $9{,}1$ bodu; 7.2: $1$, $3$, nebo $5$ soutěžících',
  4, 6, '4',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bez-kontextu'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 8',
  new List<String>{'Ze čtverce o straně $12\\ \\mathrm{cm}$ odstřihneme dva shodné trojúhelníky (viz obrázek). Vznikne rovnoramenný lichoběžník, jehož kratší základna má délku $2\\ \\mathrm{cm}$.','8.1 Určete, o kolik $\\mathrm{cm}^2$ je obsah čtverce větší než obsah lichoběžníku.','8.2 Vypočtěte v cm obvod lichoběžníku.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 765 155"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M4 23L5 23L5 39L4 39Z" style="fill:#000000"/><path d="M4 39L5 39L5 151L4 151Z" style="fill:#000000"/><path d="M16 49L107 49L107 139L16 139ZM50 139L16 49M73 139L107 49M138 49L172 139L195 139L229 49L138 49" style="fill:none;stroke:#000000;stroke-width:2"/><text x="233" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Ze čtverce o straně délky 12 cm odstřihneme dva shodné trojúhelníky (viz obrázek vlevo).</text><text x="201" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Vznikne tak rovnoramenný lichoběžník, jehož kratší základna má délku 2 cm.</text></svg>',
  'obr.svg',
  'Čtverec o straně 12 cm s vyznačenými dvěma odstřiženými trojúhelníky a vzniklý rovnoramenný lichoběžník s kratší základnou 2 cm.',
  '',
  new List<String>{'Lichoběžník má základny $12$ a $2$, výšku $12$; obsah $\\frac{12+2}{2}\\cdot12=84\\ \\mathrm{cm}^2$.','8.1: čtverec $144\\ \\mathrm{cm}^2$; rozdíl $144-84=60\\ \\mathrm{cm}^2$.','8.2: rameno $\\sqrt{5^2+12^2}=13\\ \\mathrm{cm}$; obvod $12+2+13+13=40\\ \\mathrm{cm}$.'},
  '8.1: o $60\\ \\mathrm{cm}^2$; 8.2: $40\\ \\mathrm{cm}$',
  3, 5, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD25C0T04', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
