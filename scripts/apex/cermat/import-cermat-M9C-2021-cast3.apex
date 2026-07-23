String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD21C0T03';
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
  'CERMAT M9C 2021 – úloha 8',
  new List<String>{'Z celých dlaždic tvaru obdélníku o rozměrech 18 cm a 8 cm je sestaven nejmenší možný čtverec. Z každého ze čtyř rohů tohoto čtverce odebereme po jedné dlaždici a dostaneme nový útvar. Jedna strana čtverce je rovnoběžná s delšími stranami všech dlaždic.','8.1 Vypočtěte v cm délku strany sestaveného čtverce.','8.2 Vypočtěte počet dlaždic v novém útvaru.','8.3 Vypočtěte v cm obvod nového útvaru.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 350" font-family="sans-serif"><rect x="30" y="20" width="288" height="288" fill="none" stroke="#aaa" stroke-width="1" stroke-dasharray="5 4"/><polygon points="102,20 246,20 246,52 318,52 318,276 246,276 246,308 102,308 102,276 30,276 30,52 102,52" fill="#c9c9c9" stroke="#000" stroke-width="1.8"/><line x1="102" y1="52" x2="102" y2="276" stroke="#7a7a7a" stroke-width="0.7"/><line x1="174" y1="52" x2="174" y2="276" stroke="#7a7a7a" stroke-width="0.7"/><line x1="246" y1="52" x2="246" y2="276" stroke="#7a7a7a" stroke-width="0.7"/><line x1="30" y1="52" x2="318" y2="52" stroke="#7a7a7a" stroke-width="0.7"/><line x1="30" y1="84" x2="318" y2="84" stroke="#7a7a7a" stroke-width="0.7"/><line x1="30" y1="116" x2="318" y2="116" stroke="#7a7a7a" stroke-width="0.7"/><line x1="30" y1="148" x2="318" y2="148" stroke="#7a7a7a" stroke-width="0.7"/><line x1="30" y1="180" x2="318" y2="180" stroke="#7a7a7a" stroke-width="0.7"/><line x1="30" y1="212" x2="318" y2="212" stroke="#7a7a7a" stroke-width="0.7"/><line x1="30" y1="244" x2="318" y2="244" stroke="#7a7a7a" stroke-width="0.7"/><line x1="30" y1="276" x2="318" y2="276" stroke="#7a7a7a" stroke-width="0.7"/><text x="174" y="334" font-size="15" text-anchor="middle">72 cm</text><text x="34" y="16" font-size="12">dlaždice 18 cm × 8 cm</text></svg>',
  'dlazdice.svg',
  'Čtverec sestavený z obdélníkových dlaždic 18 cm × 8 cm se čtyřmi odebranými rohovými dlaždicemi.',
  'Schematický nákres nového útvaru (rozměry dle zadání)',
  new List<String>{'8.1 Strana čtverce musí být násobkem 18 cm i 8 cm; nejmenší je nejmenší společný násobek $\\mathrm{lcm}(18,8)=72$ cm.','8.2 Čtverec obsahuje $\\dfrac{72}{18}\\cdot\\dfrac{72}{8}=4\\cdot 9=36$ dlaždic; po odebrání 4 rohových zbývá $36-4=32$ dlaždic.','8.3 Odebráním rohové dlaždice se obvod nezmění (ubyté vnější strany nahradí stejně dlouhé vnitřní strany), proto $o=4\\cdot 72=288$ cm.'},
  '8.1: $72$ cm; 8.2: $32$ dlaždic; 8.3: $288$ cm',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2021 – úloha 9',
  new List<String>{'V rovině leží body $A$, $B$, $M$ (viz obrázek).','Body $A$, $B$ jsou vrcholy obdélníku $ABCD$. Bod $M$ leží na téže kružnici $k$ jako všechny vrcholy obdélníku $ABCD$.','9.1 Sestrojte střed kružnice $k$ a označte ho písmenem $S$.','9.2 Sestrojte vrcholy $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 420" font-family="sans-serif"> <rect x="8" y="8" width="604" height="404" fill="none" stroke="#ccc"/> <line x1="293" y1="73" x2="307" y2="87" stroke="#000" stroke-width="1.6"/> <line x1="293" y1="87" x2="307" y2="73" stroke="#000" stroke-width="1.6"/> <text x="300" y="66" font-size="16" font-style="italic">M</text> <line x1="143" y1="293" x2="157" y2="307" stroke="#000" stroke-width="1.6"/> <line x1="143" y1="307" x2="157" y2="293" stroke="#000" stroke-width="1.6"/> <text x="132" y="330" font-size="16" font-style="italic">A</text> <line x1="423" y1="373" x2="437" y2="387" stroke="#000" stroke-width="1.6"/> <line x1="423" y1="387" x2="437" y2="373" stroke="#000" stroke-width="1.6"/> <text x="444" y="392" font-size="16" font-style="italic">B</text> </svg>',
  'body-abm.svg',
  'Body A, B a M v rovině (A vlevo dole, B vpravo dole, M nahoře).',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Vrcholy obdélníku i bod $M$ leží na kružnici $k$. Střed $S$ je průsečíkem os úseček $AB$ a $BM$ (střed kružnice opsané trojúhelníku $ABM$); kružnice $k$ má střed $S$ a poloměr $|SA|$.','Úhlopříčky obdélníku jsou průměry kružnice a procházejí středem $S$. Vrchol $C$ je průsečík přímky $AS$ s kružnicí $k$ (bod souměrný s $A$ podle $S$), vrchol $D$ je průsečík přímky $BS$ s kružnicí $k$ (bod souměrný s $B$ podle $S$). Úloha má jedno řešení.'},
  'Střed $S$ je průsečík os úseček $AB$ a $BM$ (střed kružnice opsané); vrcholy $C$, $D$ jsou body souměrné s $A$, $B$ podle středu $S$ na kružnici $k$ – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
