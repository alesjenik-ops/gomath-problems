String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD26C0T03';
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
  'CERMAT M9C 2026 – úloha 7',
  new List<String>{'Slepením šedé krychle s povrchem 54 cm² a bílého hranolu vznikne velký hranol $ABCDEFGH$ (viz obrázek). Nejdelší hrana bílého hranolu je o polovinu delší než hrana šedé krychle.','7.1 Vypočtěte v cm délku hrany šedé krychle.','7.2 Vypočtěte v cm³ objem velkého hranolu $ABCDEFGH$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 240" font-family="sans-serif"> <rect x="216" y="100" width="104" height="100" fill="#cfcfcf" stroke="#000"/> <polygon points="216,100 320,100 360,70 256,70" fill="#dedede" stroke="#000"/> <polygon points="320,100 360,70 360,170 320,200" fill="#bdbdbd" stroke="#000"/> <polygon points="60,200 320,200 320,100 60,100" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="60,100 320,100 360,70 100,70" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="320" y1="200" x2="360" y2="170" stroke="#000" stroke-width="1.5"/> <line x1="360" y1="170" x2="360" y2="70" stroke="#000" stroke-width="1.5"/> <line x1="216" y1="200" x2="216" y2="100" stroke="#000"/> <line x1="216" y1="100" x2="256" y2="70" stroke="#000"/> <line x1="60" y1="200" x2="100" y2="170" stroke="#000" stroke-dasharray="4 4"/> <line x1="100" y1="170" x2="360" y2="170" stroke="#000" stroke-dasharray="4 4"/> <line x1="100" y1="170" x2="100" y2="70" stroke="#000" stroke-dasharray="4 4"/> <text x="50" y="216" font-size="14" font-style="italic">A</text> <text x="316" y="216" font-size="14" font-style="italic">B</text> <text x="366" y="184" font-size="14" font-style="italic">C</text> <text x="86" y="185" font-size="14" font-style="italic">D</text> <text x="46" y="98" font-size="14" font-style="italic">E</text> <text x="322" y="96" font-size="14" font-style="italic">F</text> <text x="366" y="70" font-size="14" font-style="italic">G</text> <text x="88" y="70" font-size="14" font-style="italic">H</text> </svg>',
  'hranol-krychle.svg',
  'Velký hranol ABCDEFGH složený z bílého hranolu vlevo a šedé krychle vpravo.',
  'Schematický nákres tělesa',
  new List<String>{'7.1 Povrch krychle je $6a^2=54$ cm², odtud $a^2=9$, tedy hrana šedé krychle $a=3$ cm.','7.2 Nejdelší hrana bílého hranolu je o polovinu delší než hrana krychle, tj. $3\\cdot 1{,}5=4{,}5$ cm. Velký hranol má čtvercovou podstavu $3\\times 3$ cm a délku $3+4{,}5=7{,}5$ cm, objem $3\\cdot 3\\cdot 7{,}5=67{,}5$ cm³.'},
  '7.1: 3 cm; 7.2: $67{,}5$ cm³',
  3, 5, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
