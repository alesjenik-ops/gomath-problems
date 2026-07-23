String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD25C0T04';
Integer YEAR = 2025;

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
  'CERMAT M7D 2025 - uloha 10',
  new List<String>{'Kruznice se stredem $S$ prochazi body $A$, $B$, $K$, $L$. Usecky $AB$ a $KL$ se protinaji v bode $S$. V obrazku jsou vyznaceny velikosti nekterych uhlu (obrazek je pouze ilustrativni, uhly nemerte, ale vypoctete).','Rozhodnete o kazdem z tvrzeni 10.1-10.3, zda je pravdive (A), ci nikoli (N).','10.1 $\\alpha>64^{\\circ}$','10.2 $\\alpha+\\beta>90^{\\circ}$','10.3 $\\gamma-\\alpha>\\delta$'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 310" font-family="sans-serif"><circle cx="230" cy="150" r="120" fill="none" stroke="#000" stroke-width="1.5"/><line x1="110" y1="150" x2="350" y2="150" stroke="#000" stroke-width="1.5"/><line x1="170" y1="45" x2="290" y2="255" stroke="#000" stroke-width="1.5"/><line x1="170" y1="45" x2="110" y2="150" stroke="#000" stroke-width="1.5"/><line x1="170" y1="45" x2="350" y2="150" stroke="#000" stroke-width="1.5"/><circle cx="230" cy="150" r="2.5" fill="#000"/><text x="92" y="155" font-size="15" font-style="italic">A</text><text x="356" y="153" font-size="15" font-style="italic">B</text><text x="160" y="38" font-size="15" font-style="italic">K</text><text x="294" y="270" font-size="15" font-style="italic">L</text><text x="233" y="167" font-size="14" font-style="italic">S</text><text x="182" y="82" font-size="12">64°</text><text x="126" y="144" font-size="13" font-style="italic">α</text><text x="204" y="142" font-size="13" font-style="italic">δ</text><text x="243" y="143" font-size="13" font-style="italic">γ</text><text x="322" y="143" font-size="13" font-style="italic">β</text></svg>',
  'kruznice-prumery.svg',
  'Kruznice se stredem S; prumery AB (vodorovny) a KL; trojuhelnik AKB s vyznacenym uhlem 64 stupnu u vrcholu K a uhly alfa, beta, gama, delta.',
  'Vychozi obrazek k uloze 10',
  new List<String>{'Usecky $AB$ a $KL$ prochazi stredem $S$, jsou to tedy prumery. Trojuhelnik $ASK$ je rovnoramenny ($|SA|=|SK|$), proto $\\alpha=|\\angle AKS|=64^{\\circ}$ (vyznaceny uhel).','10.1 $\\alpha=64^{\\circ}$, neni tedy vetsi nez $64^{\\circ}$ - N.','10.2 Nad prumerem $AB$ je uhel $AKB$ pravy (Thaletova veta), tedy $\\alpha+\\beta=90^{\\circ}$, neni vetsi nez $90^{\\circ}$ - N.','10.3 $\\beta=90^{\\circ}-64^{\\circ}=26^{\\circ}$, $\\delta=|\\angle ASK|=180^{\\circ}-2\\alpha=52^{\\circ}$, $\\gamma=|\\angle KSB|=180^{\\circ}-2\\beta=128^{\\circ}$. Pak $\\gamma-\\alpha=128^{\\circ}-64^{\\circ}=64^{\\circ}>52^{\\circ}=\\delta$ - A.'},
  '10.1: N; 10.2: N; 10.3: A',
  4, 6, '4',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2025 - uloha 11',
  new List<String>{'Ze ctverce o strane delky $14$ cm odstrihneme ctyri pravouhle trojuhelniky (viz obrazek). Vznikne tak sestiuhelnik, ktery se sklada ze dvou ruznych rovnoramennych lichobezniku. Oba tyto lichobezniky maji kratsi zakladnu delky $6$ cm.','Jaky je obsah sestiuhelniku?'},
  new List<String>{'A) $112$ cm$^2$','B) $120$ cm$^2$','C) $140$ cm$^2$','D) $154$ cm$^2$','E) vice nez $154$ cm$^2$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 260" font-family="sans-serif"><rect x="40" y="40" width="180" height="180" fill="none" stroke="#999"/><polygon points="92,40 168,40 220,130 168,220 92,220 40,130" fill="none" stroke="#000" stroke-width="1.8"/><line x1="40" y1="130" x2="220" y2="130" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/></svg>',
  'ctverec-sestiuhelnik.svg',
  'Ctverec o strane 14 cm se vepsanym sestiuhelnikem slozenym ze dvou rovnoramennych lichobezniku, ve stredu vodorovna carkovana usecka.',
  'Sestiuhelnik vznikly odstrizenim ctyr trojuhelniku',
  new List<String>{'Sestiuhelnik se sklada ze dvou lichobezniku se spolecnou delsi zakladnou (stredni prickou) delky $14$ cm, kratsi zakladnou $6$ cm a vyskou $7$ cm. Kazdy ma obsah $\\frac{14+6}{2}\\cdot 7=70$ cm$^2$, dohromady $2\\cdot 70=140$ cm$^2$.'},
  'C) $140$ cm$^2$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2025 - uloha 12',
  new List<String>{'Podlaha chodby ma tvar obdelniku, sirka chodby je $3$ m. Cela podlaha chodby je vydlazdena celkem $216$ stejnymi ctvercovymi dlazdicemi. Delka strany dlazdice v cm je vyjadrena celym cislem. (Dlazdice jsou polozeny tesne vedle sebe, sirku spar zanedbavame.)','Jaka je nejmensi mozna delka chodby?'},
  new List<String>{'A) mene nez $360$ cm','B) $360$ cm','C) $400$ cm','D) $432$ cm','E) $450$ cm'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Sirka $300$ cm musi byt delitelna delkou dlazdice $d$. Po sirce je $\\frac{300}{d}$ dlazdic, po delce $\\frac{216}{300/d}=\\frac{18d}{25}$ dlazdic, coz musi byt cele cislo; proto $d$ musi byt nasobek $25$. Nejmensi vyhovujici $d=25$ cm (deli $300$) dava delku $\\frac{18\\cdot 25}{25}\\cdot 25=450$ cm. Vetsi $d$ vede k delsi chodbe, nejmensi delka je tedy $450$ cm.'},
  'E) $450$ cm',
  2, 5, '4',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
