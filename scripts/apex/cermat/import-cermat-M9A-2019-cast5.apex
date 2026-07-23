String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M9A 2019 – úloha 12',
  new List<String>{'Na obrázku je kosočtverec (všechny čtyři strany jsou shodné) a k němu připojený trojúhelník; strana kosočtverce vycházející z pravého dolního vrcholu pokračuje přímo (v jedné přímce) do dolního vrcholu trojúhelníku. Jsou vyznačeny úhly $\\alpha + 24^\\circ$, $68^\\circ$ a $\\alpha$ (viz obrázek). Velikosti úhlů neměřte, ale vypočtěte.','Jaká je velikost úhlu $\\alpha$?'},
  new List<String>{'A) $88^\\circ$','B) $90^\\circ$','C) $92^\\circ$','D) $94^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif"> <polygon points="110,55 365,45 300,165 45,175" fill="none" stroke="#000" stroke-width="2"/> <line x1="45" y1="175" x2="248" y2="261" stroke="#000" stroke-width="2"/> <line x1="300" y1="165" x2="248" y2="261" stroke="#000" stroke-width="2"/> <text x="145" y="90" font-size="15">α + 24°</text> <text x="300" y="200" font-size="14">68°</text> <text x="240" y="250" font-size="15">α</text> <line x1="235" y1="47" x2="240" y2="53" stroke="#000"/><line x1="240" y1="47" x2="245" y2="53" stroke="#000"/> <line x1="330" y1="102" x2="337" y2="107" stroke="#000"/><line x1="335" y1="100" x2="342" y2="105" stroke="#000"/> <line x1="170" y1="167" x2="177" y2="172" stroke="#000"/><line x1="175" y1="165" x2="182" y2="170" stroke="#000"/> <line x1="75" y1="112" x2="82" y2="117" stroke="#000"/><line x1="80" y1="110" x2="87" y2="115" stroke="#000"/> </svg>',
  'kosoctverec-uhel.svg',
  'Kosočtverec s vyznačeným úhlem alfa plus 24 stupňů u horního levého vrcholu; na jeho pravou stranu navazuje v přímce trojúhelník s úhly 68 stupňů a alfa.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'V kosočtverci jsou protější úhly shodné, takže vnitřní úhel u pravého dolního vrcholu je rovněž $\\alpha + 24^\\circ$. Protože strana kosočtverce pokračuje odtud přímo do vrcholu trojúhelníku, jsou úhly $\\alpha + 24^\\circ$ a $68^\\circ$ vedlejší (doplňují se do $180^\\circ$): $(\\alpha + 24^\\circ) + 68^\\circ = 180^\\circ$, odtud $\\alpha = 88^\\circ$.'},
  'A) $88^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 13',
  new List<String>{'Čtverec se stranou délky $17$ cm je rozdělen na šedý šestiúhelník a dva shodné bílé trojúhelníky. Nejdelší strana bílého trojúhelníku má délku $17$ cm. Nejkratší strana šedého šestiúhelníku měří $2$ cm (viz obrázek).','Jaký je obsah šedého šestiúhelníku?'},
  new List<String>{'A) $127$ cm²','B) $144$ cm²','C) $169$ cm²','D) $177$ cm²','E) jiný obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 340" font-family="sans-serif"> <rect x="60" y="30" width="270" height="270" fill="#ffffff" stroke="#000" stroke-width="2"/> <polygon points="60,30 92,30 330,157 330,300 298,300 60,173" fill="#c9c9c9" stroke="#000" stroke-width="1.5"/> <text x="66" y="22" font-size="13">2 cm</text> <text x="215" y="22" font-size="13" text-anchor="middle">17 cm</text> <text x="200" y="320" font-size="13" text-anchor="middle">17 cm</text> </svg>',
  'ctverec-sestiuhelnik.svg',
  'Čtverec o straně 17 cm rozdělený na šedý šestiúhelník a dva shodné bílé pravoúhlé trojúhelníky v protějších rozích.',
  'Čtverec rozdělený na šestiúhelník a dva trojúhelníky',
  new List<String>{'Každý bílý trojúhelník je pravoúhlý s přeponou (nejdelší stranou) $17$ cm. Nejkratší strana šestiúhelníku $2$ cm je zbytek strany čtverce, takže delší odvěsna trojúhelníku je $17 - 2 = 15$ cm. Druhá odvěsna: $\\sqrt{17^2 - 15^2} = \\sqrt{64} = 8$ cm (trojúhelník $8$–$15$–$17$). Obsah jednoho trojúhelníku $\\frac{1}{2}\\cdot 15\\cdot 8 = 60$ cm². Obsah čtverce $17^2 = 289$ cm². Šedý šestiúhelník $289 - 2\\cdot 60 = 169$ cm².'},
  'C) $169$ cm²',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
