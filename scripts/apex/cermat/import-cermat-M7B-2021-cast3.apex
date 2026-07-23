String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD21C0T02';
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
  'CERMAT M7B 2021 – úloha 7',
  new List<String>{'Dva shodné obdélníky mají rozměry $2$ cm a $6$ cm. Jeden z obdélníků byl rozstřižen na dva nestejné obdélníkové díly. Poměr obsahů většího a menšího dílu je $3:1$. K sestavení nového obrazce se použil jeden celý obdélník a větší díl druhého obdélníku (viz obrázek).','7.1 Vypočtěte v cm² obsah nového obrazce.','7.2 Vypočtěte v cm obvod nového obrazce.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 230" font-family="sans-serif"> <rect x="60" y="30" width="180" height="60" fill="none" stroke="#000" stroke-width="1.5"/> <text x="150" y="22" font-size="13" text-anchor="middle">6 cm</text> <text x="48" y="64" font-size="13" text-anchor="end">2 cm</text> <rect x="60" y="120" width="180" height="60" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="195" y1="120" x2="195" y2="180" stroke="#000" stroke-width="1.5"/> <text x="48" y="154" font-size="13" text-anchor="end">2 cm</text> <text x="370" y="40" font-size="13" text-anchor="middle" font-weight="bold">Novy obrazec</text> <polygon points="310,190 430,190 430,60 390,60 390,150 310,150" fill="none" stroke="#000" stroke-width="1.5"/> </svg>',
  'novy-obrazec.svg',
  'Dva obdélníky dva krát šest centimetrů, jeden rozstřižený v poměru tři ku jedné, a nový obrazec ve tvaru písmene L.',
  'Obdélníky a nový obrazec',
  new List<String>{'7.1 Obdélník má obsah $2\\cdot 6=12$ cm². Větší díl je $\\frac{3}{4}$ z $12$, tj. $9$ cm². Nový obrazec: $12+9=21$ cm².','7.2 Větší díl má rozměry $2$ cm a $4{,}5$ cm. Nový obrazec ve tvaru L má obvod $6+6{,}5+2+4{,}5+4+2=25$ cm.'},
  '7.1: $21$ cm²; 7.2: $25$ cm',
  3, 6, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2021 – úloha 8',
  new List<String>{'V rovině leží body $D$, $K$, $L$ a přímka $o$ (viz obrázek). Bod $D$ je vrchol rovnoběžníku $ABCD$. V osové souměrnosti s osou $o$ je bod $K$ obrazem vrcholu $A$ rovnoběžníku $ABCD$ a bod $L$ obrazem vrcholu $B$ tohoto rovnoběžníku.','8.1 Sestrojte vrcholy $A$, $B$ rovnoběžníku $ABCD$ a označte je písmeny.','8.2 Sestrojte vrchol $C$ rovnoběžníku $ABCD$, označte jej písmenem a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif"> <rect x="8" y="8" width="464" height="304" fill="none" stroke="#ccc"/> <line x1="70" y1="270" x2="420" y2="110" stroke="#000" stroke-width="2"/> <text x="428" y="108" font-size="15" font-style="italic">o</text> <line x1="112" y1="182" x2="128" y2="198" stroke="#000"/><line x1="128" y1="182" x2="112" y2="198" stroke="#000"/> <text x="104" y="210" font-size="15" font-style="italic">D</text> <line x1="242" y1="142" x2="258" y2="158" stroke="#000"/><line x1="258" y1="142" x2="242" y2="158" stroke="#000"/> <text x="250" y="134" font-size="15" font-style="italic">K</text> <line x1="342" y1="225" x2="358" y2="241" stroke="#000"/><line x1="358" y1="225" x2="342" y2="241" stroke="#000"/> <text x="350" y="262" font-size="15" font-style="italic">L</text> </svg>',
  'body-DKL-o.svg',
  'Body D, K, L a šikmá přímka o v rovině.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Vrcholy $A$, $B$ získáme jako obrazy bodů $K$, $L$ v osové souměrnosti podle osy $o$ (pata kolmice z $K$, resp. $L$ na osu $o$ a nanesení stejné vzdálenosti na opačnou stranu). Vrchol $C$ doplníme tak, aby čtyřúhelník $ABCD$ byl rovnoběžník (strana $CD$ je rovnoběžná a shodná se stranou $BA$).'},
  'Konstrukce rovnoběžníku $ABCD$: $A$, $B$ jsou obrazy bodů $K$, $L$ v osové souměrnosti podle osy $o$; vrchol $C$ dopočteme (viz obrázek v klíči).',
  3, 7, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
