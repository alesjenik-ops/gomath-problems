String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M7D 2026 – úloha 6',
  new List<String>{'Na bílé krychli $ABCDEFGH$ jsme vyznačili středy $M$, $N$ hran $AB$ a $FG$. Na třech stěnách krychle jsme zakreslili šedé pravoúhlé lichoběžníky $MBFE$, $BCNF$ a $HEFN$ (viz obrázek). Ostatní stěny krychle zůstaly celé bílé.','6.1 Zapište zlomkem v základním tvaru, jakou část plochy přední stěny tvoří šedý lichoběžník $MBFE$.','6.2 Na povrchu celé krychle je část plochy šedá a část bílá. Určete poměr obsahu šedé plochy ku obsahu bílé plochy. Poměr zapište v základním tvaru.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 300" font-family="sans-serif"> <polygon points="200,240 250,240 250,140 150,140" fill="#b8b8b8" stroke="#000"/> <polygon points="250,240 310,200 280,120 250,140" fill="#b8b8b8" stroke="#000"/> <polygon points="210,100 150,140 250,140 280,120" fill="#b8b8b8" stroke="#000"/> <line x1="150" y1="240" x2="250" y2="240" stroke="#000"/> <line x1="250" y1="240" x2="250" y2="140" stroke="#000"/> <line x1="250" y1="140" x2="150" y2="140" stroke="#000"/> <line x1="150" y1="140" x2="150" y2="240" stroke="#000"/> <line x1="150" y1="240" x2="210" y2="200" stroke="#000" stroke-dasharray="4 3"/> <line x1="210" y1="200" x2="310" y2="200" stroke="#000"/> <line x1="310" y1="200" x2="250" y2="240" stroke="#000"/> <line x1="310" y1="200" x2="310" y2="100" stroke="#000"/> <line x1="250" y1="140" x2="310" y2="100" stroke="#000"/> <line x1="310" y1="100" x2="210" y2="100" stroke="#000"/> <line x1="210" y1="100" x2="150" y2="140" stroke="#000"/> <line x1="210" y1="100" x2="210" y2="200" stroke="#000" stroke-dasharray="4 3"/> <text x="138" y="256" font-size="14" font-style="italic">A</text> <text x="252" y="256" font-size="14" font-style="italic">B</text> <text x="316" y="200" font-size="14" font-style="italic">C</text> <text x="196" y="214" font-size="14" font-style="italic">D</text> <text x="136" y="140" font-size="14" font-style="italic">E</text> <text x="252" y="136" font-size="14" font-style="italic">F</text> <text x="316" y="98" font-size="14" font-style="italic">G</text> <text x="196" y="98" font-size="14" font-style="italic">H</text> <text x="196" y="256" font-size="13" font-style="italic">M</text> <text x="284" y="118" font-size="13" font-style="italic">N</text> </svg>',
  'krychle-lichobezniky.svg',
  'Krychle ABCDEFGH se středy M hrany AB a N hrany FG a třemi šedými lichoběžníky MBFE, BCNF, HEFN.',
  'Schematický nákres krychle se šedými lichoběžníky',
  new List<String>{'6.1 Přední stěna $ABFE$ (jednotkový čtverec). Lichoběžník $MBFE$ má rovnoběžné strany $MB=\\frac{1}{2}$ a $EF=1$, výšku $1$: obsah $\\frac{\\frac{1}{2}+1}{2}\\cdot 1=\\frac{3}{4}$ stěny.','6.2 Každý ze tří lichoběžníků má obsah $\\frac{3}{4}$ stěny, šedá celkem $3\\cdot\\frac{3}{4}=\\frac{9}{4}$; povrch krychle $=6$ stěn, bílá $6-\\frac{9}{4}=\\frac{15}{4}$. Poměr šedá : bílá $=\\frac{9}{4}:\\frac{15}{4}=3:5$.'},
  '6.1: $\\frac{3}{4}$; 6.2: $3:5$',
  3, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
