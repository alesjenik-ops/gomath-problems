String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD26C0T01';
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
  'CERMAT M7A 2026 - uloha 5',
  new List<String>{'Na obrazku jsou dva rovnoramenne trojuhelniky $ABC$ a $EFG$. Jejich zakladny $AB$ a $EF$ jsou vyznaceny carkovane. Strany $AB$ a $FG$ jsou navzajem rovnobezne, stejne jako strany $BC$ a $EG$. Velikosti nekterych uhlu jsou uvedeny v obrazku.','Urcete ve stupnich velikost uhlu $\\gamma$ (5.1), $\\varphi$ (5.2) a $\\omega$ (5.3).','Velikosti uhlu nemerte, ale vypoctete (obrazek je pouze ilustrativni).'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 380" font-family="sans-serif"> <polygon points="150,320 330,320 240,60" fill="none" stroke="#000" stroke-width="2"/> <line x1="150" y1="320" x2="330" y2="320" stroke="#000" stroke-width="1.5" stroke-dasharray="5 5"/> <polygon points="380,150 290,330 480,320" fill="none" stroke="#000" stroke-width="2"/> <line x1="380" y1="150" x2="290" y2="330" stroke="#000" stroke-width="1.5" stroke-dasharray="5 5"/> <text x="236" y="52" font-size="15" font-style="italic">C</text> <text x="136" y="336" font-size="15" font-style="italic">A</text> <text x="332" y="336" font-size="15" font-style="italic">B</text> <text x="386" y="150" font-size="15" font-style="italic">E</text> <text x="276" y="348" font-size="15" font-style="italic">F</text> <text x="484" y="322" font-size="15" font-style="italic">G</text> <text x="230" y="96" font-size="15" font-style="italic">&#947;</text> <text x="296" y="308" font-size="12">78&#176;</text> <text x="364" y="176" font-size="15" font-style="italic">&#969;</text> <text x="306" y="320" font-size="15" font-style="italic">&#966;</text> </svg>',
  'trojuhelniky-uhly.svg',
  'Dva rovnoramenne trojuhelniky ABC a EFG se spolecne oznacenymi uhly gama, fi, omega a uhlem 78 stupnu.',
  'Vychozi obrazek k uloze 5 (ilustrativni)',
  new List<String>{'5.1 Trojuhelnik $ABC$ je rovnoramenny se zakladnou $AB$, uhel pri zakladne je $78^\\circ$, proto $\\gamma=180^\\circ-2\\cdot 78^\\circ=24^\\circ$.','5.2 Protoze $FG\\parallel AB$ a $EG\\parallel BC$, ma uhel $EGF$ stejnou velikost jako uhel $ABC$, tj. $78^\\circ$. Trojuhelnik $EFG$ je rovnoramenny se zakladnou $EF$, proto $\\varphi=(180^\\circ-78^\\circ):2=51^\\circ$.','5.3 Uhel $\\omega$ je vedlejsi k zakladnovemu uhlu pri vrcholu $E$ (velikost $51^\\circ$), proto $\\omega=180^\\circ-51^\\circ=129^\\circ$.'},
  '5.1: $\\gamma=24^\\circ$; 5.2: $\\varphi=51^\\circ$; 5.3: $\\omega=129^\\circ$',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2026 - uloha 6',
  new List<String>{'Matej mel cervene, modre, zelene a zlute samolepici ctverecky o strane delky 1 cm. Vsemi temito ctverecky presne zaplnil cely obdelnik o rozmerech 20 cm a 30 cm. (Nalepene ctverecky se neprekryvaji a nejsou mezi nimi zadne mezery.)','Ze vsech nalepenych ctverecku je petina cervenych a ze zbyvajicich ctverecku je tretina modrych. Zelenych ctverecku je o 20 mene nez zlutych.','6.1 Vypoctete, kolik cervenych a modrych ctverecku dohromady Matej nalepil.','6.2 Vyjadrete zlomkem v zakladnim tvaru, jakou cast obdelniku zaplnily zelene ctverecky.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif"> <rect x="60" y="50" width="300" height="200" fill="none" stroke="#000" stroke-width="2"/> <g fill="none" stroke="#000"> <rect x="60" y="50" width="20" height="20"/><rect x="80" y="50" width="20" height="20"/><rect x="100" y="50" width="20" height="20"/> <rect x="60" y="70" width="20" height="20"/><rect x="80" y="70" width="20" height="20"/> <rect x="60" y="90" width="20" height="20"/> </g> <text x="150" y="66" font-size="18">&#8230;</text> <text x="105" y="140" font-size="18">&#8230;</text> <text x="28" y="64" font-size="12">1 cm</text> <text x="210" y="278" font-size="13" text-anchor="middle">30 cm</text> <text x="368" y="154" font-size="13">20 cm</text> </svg>',
  'obdelnik-ctverecky.svg',
  'Obdelnik 30 krat 20 cm castecne zaplneny ctverecky 1 krat 1 cm v levem hornim rohu, se treni teckami naznacujicimi pokracovani.',
  'Schematicky nakres (rozmery dle zadani)',
  new List<String>{'Celkem je $20\\cdot 30=600$ ctverecku.','6.1 Cervenych je $\\frac{1}{5}\\cdot 600=120$. Ze zbyvajicich $600-120=480$ je modrych $\\frac{1}{3}\\cdot 480=160$. Dohromady $120+160=280$ ctverecku.','6.2 Zelene a zlute dohromady $480-160=320$. Zelenych $z$, zlutych $z+20$: $z+(z+20)=320\\Rightarrow z=150$. Cast obdelniku $\\frac{150}{600}=\\frac{1}{4}$.'},
  '6.1: $280$ ctverecku; 6.2: $\\frac{1}{4}$',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
