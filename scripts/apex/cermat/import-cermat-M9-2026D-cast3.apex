String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD26C0T04';
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
  'CERMAT M9D 2026 – úloha 7',
  new List<String>{'Na bílé krychli $ABCDEFGH$ jsou vyznačeny středy $M$, $N$ hran $AB$ a $FG$. Na třech stěnách krychle jsou zakresleny šedé pravoúhlé lichoběžníky $MBFE$, $BCNF$ a $HEFN$ (viz obrázek). Ostatní stěny krychle zůstaly celé bílé.','7.1 Zapište zlomkem v základním tvaru, jakou část plochy přední stěny tvoří šedý lichoběžník $MBFE$.','7.2 Určete poměr obsahu šedé plochy ku obsahu bílé plochy na povrchu celé krychle. Poměr zapište v základním tvaru.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 270" font-family="sans-serif"> <polygon points="150,230 230,230 230,70 70,70" fill="#b9b9b9" stroke="#000"/> <polygon points="230,230 300,185 265,48 230,70" fill="#a9a9a9" stroke="#000"/> <polygon points="140,25 70,70 230,70 265,48" fill="#cccccc" stroke="#000"/> <line x1="70" y1="230" x2="230" y2="230" stroke="#000"/> <line x1="230" y1="230" x2="230" y2="70" stroke="#000"/> <line x1="230" y1="70" x2="70" y2="70" stroke="#000"/> <line x1="70" y1="70" x2="70" y2="230" stroke="#000"/> <line x1="230" y1="70" x2="300" y2="25" stroke="#000"/> <line x1="300" y1="25" x2="140" y2="25" stroke="#000"/> <line x1="140" y1="25" x2="70" y2="70" stroke="#000"/> <line x1="230" y1="230" x2="300" y2="185" stroke="#000"/> <line x1="300" y1="185" x2="300" y2="25" stroke="#000"/> <line x1="70" y1="230" x2="140" y2="185" stroke="#000" stroke-dasharray="4 4"/> <line x1="140" y1="185" x2="300" y2="185" stroke="#000" stroke-dasharray="4 4"/> <line x1="140" y1="185" x2="140" y2="25" stroke="#000" stroke-dasharray="4 4"/> <circle cx="150" cy="230" r="2.5" fill="#000"/> <circle cx="265" cy="48" r="2.5" fill="#000"/> <text x="56" y="246" font-size="14" font-style="italic">A</text> <text x="228" y="248" font-size="14" font-style="italic">B</text> <text x="305" y="198" font-size="14" font-style="italic">C</text> <text x="122" y="200" font-size="14" font-style="italic">D</text> <text x="54" y="66" font-size="14" font-style="italic">E</text> <text x="234" y="64" font-size="14" font-style="italic">F</text> <text x="305" y="22" font-size="14" font-style="italic">G</text> <text x="126" y="20" font-size="14" font-style="italic">H</text> <text x="152" y="248" font-size="13" font-style="italic">M</text> <text x="272" y="44" font-size="13" font-style="italic">N</text> </svg>',
  'krychle-lichobezniky.svg',
  'Schematický nákres krychle ABCDEFGH v nadhledu se třemi šedými lichoběžníky MBFE, BCNF a HEFN na přední, pravé a horní stěně; M je střed hrany AB, N je střed hrany FG.',
  'Schematický nákres krychle se šedými lichoběžníky',
  new List<String>{'7.1 Přední stěna $ABFE$ je čtverec; lichoběžník $MBFE$ má rovnoběžné strany $MB$ (polovina hrany) a $EF$ (celá hrana) a výšku rovnou hraně. Jeho obsah je $\\frac{\\frac{1}{2}+1}{2}=\\frac{3}{4}$ obsahu stěny (v jednotkách hrany), tedy $\\frac{3}{4}$.','7.2 Každý ze tří šedých lichoběžníků tvoří $\\frac{3}{4}$ jedné stěny, celkem šedá plocha $=3\\cdot\\frac{3}{4}=\\frac{9}{4}$ obsahu stěny. Povrch krychle má $6$ stěn, bílá plocha $=6-\\frac{9}{4}=\\frac{15}{4}$. Poměr šedé ku bílé $=\\frac{9}{4}:\\frac{15}{4}=9:15=3:5$.'},
  '7.1: $\\frac{3}{4}$; 7.2: $3:5$',
  3, 6, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 8',
  new List<String>{'V parku běží dva běžci trasu dlouhou $8$ km. Žádný z nich svou rychlost běhu nemění. Rychlejší běžec uběhne celou trasu za $40$ minut. Přitom rychlejší běžec uběhne $3$ km za čas, za který pomalejší běžec uběhne $2\\,500$ m.','8.1 Vypočtěte v minutách, za jaký čas uběhne rychlejší běžec $3$ km.','8.2 Vypočtěte v minutách, za jaký čas uběhne pomalejší běžec celou trasu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'8.1 Rychlejší běžec uběhne $8$ km za $40$ minut, tj. $1$ km za $5$ minut; $3$ km uběhne za $15$ minut.','8.2 Za $15$ minut (kdy rychlejší uběhne $3$ km) uběhne pomalejší $2\\,500$ m $=2{,}5$ km. Celou trasu $8$ km uběhne za $\\frac{8}{2{,}5}\\cdot 15=48$ minut.'},
  '8.1: $15$ minut; 8.2: $48$ minut',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
