String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD22C0T02';
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
  'CERMAT M9B 2022 – úloha 10',
  new List<String>{'V rovině leží body $A$, $C$ a přímka $p$ (viz obrázek).','Body $A$, $C$ jsou vrcholy rovnoběžníku $ABCD$, jehož dvě strany jsou rovnoběžné s přímkou $p$. Jedna z úhlopříček rovnoběžníku $ABCD$ je k přímce $p$ kolmá.','10.1 Sestrojte střed $S$ rovnoběžníku $ABCD$ a označte ho písmenem.','10.2 Sestrojte vrcholy $B$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif"> <line x1="120" y1="70" x2="360" y2="200" stroke="#000" stroke-width="1.5"/> <text x="368" y="212" font-size="15" font-style="italic">p</text> <text x="315" y="120" font-size="14" text-anchor="middle">×</text> <text x="315" y="112" font-size="14" font-style="italic" text-anchor="middle">C</text> <text x="120" y="240" font-size="14" text-anchor="middle">×</text> <text x="120" y="258" font-size="14" font-style="italic" text-anchor="middle">A</text> </svg>',
  'body-primka-p.svg',
  'Přímka p klesající zleva doprava, bod C vpravo nahoře a bod A vlevo dole.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'10.1 Střed $S$ je střed úhlopříčky $AC$ (průsečík úhlopříček rovnoběžníku).','10.2 Bodem $S$ vedeme kolmici k přímce $p$; na ní leží úhlopříčka $BD$. Vrchol $B$ je průsečík této kolmice s rovnoběžkou s $p$ vedenou bodem $A$, vrchol $D$ je s ním souměrný podle $S$ (průsečík kolmice s rovnoběžkou s $p$ vedenou bodem $C$). Rovnoběžník $ABCD$ narýsujeme.'},
  'Konstrukce: $S$ střed úsečky $AC$; úhlopříčka $BD$ leží na kolmici k $p$ vedené bodem $S$; $B$ a $D$ jsou průsečíky této kolmice s rovnoběžkami s $p$ vedenými body $A$ a $C$ (viz obrázek v klíči).',
  3, 7, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 11',
  new List<String>{'Ze tří stejných dřevěných krychlí byl slepen čtyřboký hranol, jehož síť má obsah $126$ cm² (viz obrázek).','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).','11.1 Povrch hranolu je 14krát větší než obsah stěny jedné krychle.','11.2 Síť krychle má obsah $42$ cm².','11.3 Nejkratší hrana hranolu měří $3$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 220 170" font-family="sans-serif"> <text x="110" y="18" font-size="12" text-anchor="middle">Síť hranolu</text> <rect x="40" y="30" width="30" height="90" fill="none" stroke="#000"/> <rect x="70" y="30" width="30" height="90" fill="none" stroke="#000"/> <rect x="100" y="30" width="30" height="90" fill="none" stroke="#000"/> <rect x="130" y="30" width="30" height="90" fill="none" stroke="#000"/> <rect x="130" y="120" width="30" height="30" fill="none" stroke="#000"/> </svg>',
  'sit-hranolu.svg',
  'Síť čtyřbokého hranolu: čtyři stejné obdélníkové stěny v řadě a jedna čtvercová podstava.',
  'Síť čtyřbokého hranolu',
  new List<String>{'Hranol má rozměry $a\\times a\\times 3a$, kde $a$ je hrana krychle. Povrch (síť) $=2a^2+4\\cdot 3a^2=14a^2=126$, tedy $a^2=9$ a $a=3$ cm.','11.1 Povrch hranolu $=14a^2$, obsah stěny krychle $=a^2$; podíl je $14$ → pravdivé (Ano).','11.2 Síť (povrch) krychle $=6a^2=6\\cdot9=54$ cm², ne $42$ cm² → nepravdivé (Ne).','11.3 Nejkratší hrana hranolu je $a=3$ cm → pravdivé (Ano).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r9','stereometrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
