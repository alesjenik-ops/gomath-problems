String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD23C0T03';
Integer YEAR = 2023;

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
  'CERMAT M7C 2023 - uloha 5.2',
  new List<String>{'Pavel, Rosta a Sofie se jako triclenna stafeta prihlasili na charitativni beh dlouhy $36$ km. Trasu behu si rozdelili na tri ruzne dlouhe useky. Rosta vsak onemocnel, proto polovinu jeho useku ubehl Pavel a druhou polovinu Sofie. Ve skutecnosti tak Pavel ubehl o tretinu delsi usek, nez mel puvodne ubehnout, a Sofie o ctvrtinu delsi usek, nez mela puvodne ubehnout.','Vypoctete, kolik km mel puvodne ubehnout Rosta.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Oznacme puvodni useky $p$ (Pavel), $s$ (Sofie), $r$ (Rosta); $p+s+r=36$. Pavel navic ubehl $\\dfrac{r}{2}$, coz je tretina jeho useku: $\\dfrac{r}{2}=\\dfrac{p}{3}$, tedy $p=\\dfrac{3r}{2}$. Sofie navic ubehla $\\dfrac{r}{2}$, coz je ctvrtina jejiho useku: $\\dfrac{r}{2}=\\dfrac{s}{4}$, tedy $s=2r$. Dosazenim: $\\dfrac{3r}{2}+2r+r=36$, tj. $\\dfrac{9r}{2}=36$, $r=8$.'},
  '$8$ km',
  2, 6, '4',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2023 - uloha 6',
  new List<String>{'Sestiuhelnik na obrazku se sklada z rovnoramenneho trojuhelniku, obdelniku a ctverce. Zakladna rovnoramenneho trojuhelniku splyva s delsi stranou obdelniku a rameno tohoto trojuhelniku je o $1$ cm delsi nez strana ctverce. Obvod ctverce je stejny jako obvod trojuhelniku, ale o $8$ cm mensi nez obvod obdelniku.','6.1 Vypoctete, o kolik cm se lisi delka a sirka obdelniku.','6.2 Vypoctete, kolik cm meri rameno rovnoramenneho trojuhelniku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 210 170" font-family="sans-serif"> <polygon points="20,140 20,80 80,80 130,20 180,80 180,140" fill="none" stroke="#000" stroke-width="2"/> <line x1="80" y1="80" x2="80" y2="140" stroke="#000" stroke-width="1.3"/> <line x1="80" y1="80" x2="180" y2="80" stroke="#000" stroke-width="1.3"/> <text x="50" y="115" font-size="11" text-anchor="middle">ctverec</text> <text x="130" y="118" font-size="11" text-anchor="middle">obdelnik</text> <text x="130" y="62" font-size="11" text-anchor="middle">trojuhelnik</text> </svg>',
  'sestiuhelnik.svg',
  'Sestiuhelnik slozeny ze ctverce (vlevo), obdelniku (vpravo) a trojuhelniku (nahore).',
  'Schematicky nakres sestiuhelniku',
  new List<String>{'Oznacme stranu ctverce $a$. Rameno trojuhelniku je $a+1$, jeho zakladna se rovna delsi strane obdelniku $d$; kratsi strana obdelniku je rovna strane ctverce $a$.','Obvod ctverce = obvod trojuhelniku: $4a=d+2(a+1)$, tj. $d=2a-2$. Obvod ctverce je o $8$ mensi nez obvod obdelniku: $4a=2(d+a)-8$, tj. $d=a+4$. Z rovnic $2a-2=a+4$ plyne $a=6$ a $d=10$.','6.1 Delka a sirka obdelniku se lisi o $d-a=10-6=4$ cm.','6.2 Rameno trojuhelniku meri $a+1=7$ cm.'},
  '6.1: o $4$ cm; 6.2: $7$ cm',
  3, 6, '3',
  new List<String>{'zs2','r7','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2023 - uloha 7',
  new List<String>{'Povrch pravidelneho ctyrbokeho hranolu je $144$ cm². Obsah plaste tohoto hranolu je dvakrat vetsi nez obsah jedne jeho ctvercove podstavy. (Plast tohoto hranolu tvori ctyri shodne bocni steny.)','7.1 Vypoctete v cm delku strany ctvercove podstavy.','7.2 Vypoctete v cm² obsah jedne bocni steny hranolu.','7.3 Vypoctete v cm³ objem hranolu.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 220 210" font-family="sans-serif"> <rect x="40" y="60" width="100" height="120" fill="none" stroke="#000" stroke-width="2"/> <line x1="40" y1="60" x2="85" y2="20" stroke="#000" stroke-width="2"/> <line x1="140" y1="60" x2="185" y2="20" stroke="#000" stroke-width="2"/> <line x1="140" y1="180" x2="185" y2="140" stroke="#000" stroke-width="2"/> <line x1="85" y1="20" x2="185" y2="20" stroke="#000" stroke-width="2"/> <line x1="185" y1="20" x2="185" y2="140" stroke="#000" stroke-width="2"/> <line x1="40" y1="180" x2="85" y2="140" stroke="#000" stroke-width="1.2" stroke-dasharray="4 4"/> <line x1="85" y1="20" x2="85" y2="140" stroke="#000" stroke-width="1.2" stroke-dasharray="4 4"/> <line x1="85" y1="140" x2="185" y2="140" stroke="#000" stroke-width="1.2" stroke-dasharray="4 4"/> </svg>',
  'hranol.svg',
  'Pravidelny ctyrboky hranol (kvadr se ctvercovou podstavou) v kosem promitani.',
  'Schematicky nakres hranolu',
  new List<String>{'Povrch $=2\\cdot S_p+S_{pl}$, kde plast $S_{pl}=2S_p$. Tedy $144=2S_p+2S_p=4S_p$, odkud $S_p=36$ cm².','7.1 Strana podstavy $a=\\sqrt{36}=6$ cm.','7.2 Plast $S_{pl}=2\\cdot 36=72$ cm², jedna ze ctyr shodnych bocnich sten ma obsah $72:4=18$ cm².','7.3 Z $a\\cdot v=18$ a $a=6$ plyne vyska $v=3$ cm; objem $V=S_p\\cdot v=36\\cdot 3=108$ cm³.'},
  '7.1: $6$ cm; 7.2: $18$ cm²; 7.3: $108$ cm³',
  3, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
