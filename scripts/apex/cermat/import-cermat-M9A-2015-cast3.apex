String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M9A 2015 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $B$ a $Y$ (viz obrázek).','10.1 Na polopřímce $BY$ sestrojte bod $C$ tak, aby body $A$, $B$, $C$ tvořily vrcholy rovnoramenného trojúhelníku se základnou $AB$, a trojúhelník $ABC$ narýsujte.','10.2 Sestrojte osu souměrnosti $o$ trojúhelníku $ABC$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 200" font-family="sans-serif" font-size="15"> <line x1="394" y1="39" x2="406" y2="51" stroke="#000" stroke-width="2"/><line x1="406" y1="39" x2="394" y2="51" stroke="#000" stroke-width="2"/> <text x="400" y="30" text-anchor="middle" font-style="italic">B</text> <line x1="114" y1="74" x2="126" y2="86" stroke="#000" stroke-width="2"/><line x1="126" y1="74" x2="114" y2="86" stroke="#000" stroke-width="2"/> <text x="120" y="66" text-anchor="middle" font-style="italic">Y</text> <line x1="144" y1="149" x2="156" y2="161" stroke="#000" stroke-width="2"/><line x1="156" y1="149" x2="144" y2="161" stroke="#000" stroke-width="2"/> <text x="150" y="180" text-anchor="middle" font-style="italic">A</text> </svg>',
  'body-ABY.svg',
  'Tři body v rovině označené křížky a písmeny A, B a Y.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'10.1 V rovnoramenném trojúhelníku se základnou $AB$ platí $|CA|=|CB|$, vrchol $C$ tedy leží na ose úsečky $AB$. Bod $C$ je průsečík osy úsečky $AB$ s polopřímkou $BY$.','10.2 Osou souměrnosti rovnoramenného trojúhelníku $ABC$ je osa základny $AB$, tj. přímka procházející vrcholem $C$ a středem úsečky $AB$.'},
  'Bod $C$ je průsečík osy úsečky $AB$ s polopřímkou $BY$; osou souměrnosti $o$ je osa úsečky $AB$, která prochází bodem $C$ – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 11',
  new List<String>{'Uvnitř čtverce je sestrojen trojúhelník, jehož jedna strana je současně stranou čtverce. Přemístěním trojúhelníku k protější straně čtverce vznikne nový obrazec. Obvod čtverce je $40$ cm a obvod trojúhelníku $25$ cm.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Obvod nového obrazce je $50$ cm.','11.2 Obsah čtverce je $100$ cm².','11.3 Obsah nového obrazce je větší než obsah čtverce.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 220" font-family="sans-serif" font-size="13"> <rect x="30" y="70" width="110" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/> <text x="85" y="128" text-anchor="middle" font-style="italic">o = 40 cm</text> <rect x="200" y="70" width="110" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/> <polygon points="200,180 310,180 252,108" fill="#ffffff" stroke="#000" stroke-width="2"/> <text x="262" y="174" text-anchor="middle" font-style="italic">o = 25 cm</text> <polygon points="380,70 435,10 490,70 490,180 435,110 380,180" fill="#d3d3d3" stroke="#000" stroke-width="2"/> <line x1="380" y1="180" x2="490" y2="180" stroke="#888" stroke-width="1" stroke-dasharray="4 4"/> <line x1="437" y1="176" x2="437" y2="48" stroke="#888" stroke-width="1.5"/> <polygon points="437,36 431,52 443,52" fill="#888"/> </svg>',
  'ctverec-trojuhelnik.svg',
  'Tři obrazce: čtverec s obvodem 40 cm, tentýž čtverec s trojúhelníkem o obvodu 25 cm uvnitř a nový obrazec se zářezem dole a hrotem nahoře.',
  'Čtverec, vepsaný trojúhelník a nový obrazec',
  new List<String>{'Strana čtverce je $40:4=10$ cm; je zároveň stranou trojúhelníku, takže obě ramena trojúhelníku mají dohromady $25-10=15$ cm.','11.1 U nového obrazce nahradí dole ramena trojúhelníku ($15$ cm) spodní stranu čtverce a nahoře ramena ($15$ cm) přibudou; boční strany dají $2\\cdot 10=20$ cm. Obvod je $15+15+20=50$ cm → Ano.','11.2 Obsah čtverce je $10\\cdot 10=100$ cm² → Ano.','11.3 Trojúhelník byl pouze přemístěn, obsah nového obrazce je stejný jako obsah čtverce, není větší → Ne.'},
  '11.1: Ano; 11.2: Ano; 11.3: Ne',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
