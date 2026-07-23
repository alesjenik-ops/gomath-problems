String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD21C0T01';
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
  'CERMAT M9A 2021 – úloha 12',
  new List<String>{'V rovině leží přímka $AB$ a rovnoběžník $ABCD$. Rovnoběžník má vnitřní úhly o velikostech $\\alpha$, $\\delta$ (viz obrázek).','Jaká je velikost úhlu $\\delta$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $108^\\circ$','B) $108^\\circ$','C) $135^\\circ$','D) $144^\\circ$','E) větší než $144^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif"> <line x1="60" y1="250" x2="440" y2="250" stroke="#000" stroke-width="1.5"/> <polygon points="170,250 290,250 411,162 291,162" fill="none" stroke="#000" stroke-width="2"/> <path d="M 196 250 A 26 26 0 0 0 191 235" fill="none" stroke="#000" stroke-width="1.2"/> <path d="M 136 250 A 34 34 0 0 1 197 231" fill="none" stroke="#000" stroke-width="1.2"/> <path d="M 315 162 A 24 24 0 0 1 272 173" fill="none" stroke="#000" stroke-width="1.2"/> <text x="204" y="242" font-size="16" font-style="italic">α</text> <text x="146" y="240" font-size="16">4α</text> <text x="300" y="184" font-size="16" font-style="italic">δ</text> <text x="164" y="268" font-size="15" font-style="italic">A</text> <text x="286" y="268" font-size="15" font-style="italic">B</text> <text x="416" y="158" font-size="15" font-style="italic">C</text> <text x="278" y="156" font-size="15" font-style="italic">D</text> </svg>',
  'rovnobeznik-ABCD.svg',
  'Přímka AB s rovnoběžníkem ABCD; při vrcholu A úhly alfa a 4 alfa, při vrcholu D úhel delta.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Úhel $4\\alpha$ (mezi přímkou $AB$ vlevo od $A$ a stranou $AD$) a vnitřní úhel $\\alpha$ při vrcholu $A$ jsou vedlejší, tedy $4\\alpha+\\alpha=180^\\circ$, odkud $\\alpha=36^\\circ$. V rovnoběžníku jsou sousední úhly doplňkové, proto $\\delta=180^\\circ-\\alpha=180^\\circ-36^\\circ=144^\\circ$.'},
  'D) $144^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 13',
  new List<String>{'Pravoúhlý lichoběžník $ABCD$ je úsečkou $DP$ délky $12$ cm rozdělen na čtverec $PBCD$ a trojúhelník $APD$. Obsah trojúhelníku $APD$ je $6$krát menší než obsah čtverce $PBCD$. Z lichoběžníku $ABCD$ oddělíme šedý trojúhelník $ABC$ (viz obrázek).','Jaký je obvod šedého trojúhelníku $ABC$?'},
  new List<String>{'A) menší než $48$ cm','B) $48$ cm','C) $50$ cm','D) $52$ cm','E) větší než $52$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 220" font-family="sans-serif"> <polygon points="60,180 180,180 180,90 90,90" fill="none" stroke="#000" stroke-width="2"/> <line x1="90" y1="90" x2="90" y2="180" stroke="#000" stroke-width="1.5"/> <text x="80" y="84" font-size="15" font-style="italic">D</text> <text x="183" y="84" font-size="15" font-style="italic">C</text> <text x="50" y="196" font-size="15" font-style="italic">A</text> <text x="85" y="196" font-size="15" font-style="italic">P</text> <text x="183" y="196" font-size="15" font-style="italic">B</text> <polygon points="290,180 410,180 410,90 320,90" fill="none" stroke="#000" stroke-width="2"/> <polygon points="290,180 410,180 410,90" fill="#cfcfcf" stroke="#000" stroke-width="2"/> <text x="310" y="84" font-size="15" font-style="italic">D</text> <text x="413" y="84" font-size="15" font-style="italic">C</text> <text x="280" y="196" font-size="15" font-style="italic">A</text> <text x="413" y="196" font-size="15" font-style="italic">B</text> </svg>',
  'lichobeznik-trojuhelnik.svg',
  'Vlevo pravoúhlý lichoběžník ABCD rozdělený úsečkou DP na čtverec PBCD a trojúhelník APD; vpravo týž lichoběžník se šedým trojúhelníkem ABC.',
  'Rozdělení lichoběžníku a šedý trojúhelník ABC',
  new List<String>{'Čtverec $PBCD$ má stranu $DP=12$ cm, obsah $144$ cm². Trojúhelník $APD$ má obsah $144:6=24$ cm² a výšku $DP=12$ cm, tedy $\\dfrac{1}{2}\\cdot AP\\cdot 12=24$, odkud $AP=4$ cm.','Trojúhelník $ABC$ je pravoúhlý s odvěsnami $AB=AP+PB=4+12=16$ cm a $BC=12$ cm; přepona $AC=\\sqrt{16^2+12^2}=\\sqrt{400}=20$ cm. Obvod $=16+12+20=48$ cm.'},
  'B) $48$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
