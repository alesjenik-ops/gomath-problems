String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M9B 2018 – úloha 13',
  new List<String>{'Kolmý hranol, jehož podstavy tvoří pravoúhlé trojúhelníky, má stejný objem jako kvádr (viz obrázek). Hranol má odvěsny podstavy $12$ dm a $24$ dm a délku $10$ dm. Kvádr má rozměry podstavy $12$ dm a $10$ dm.','Jaký je chybějící rozměr kvádru?'},
  new List<String>{'A) $8$ dm','B) $12$ dm','C) $15$ dm','D) $16$ dm','E) jiný počet dm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 290" font-family="sans-serif"> <polygon points="60,230 60,105 280,230" fill="none" stroke="#000" stroke-width="2"/> <line x1="60" y1="105" x2="110" y2="78" stroke="#000" stroke-width="2"/> <line x1="60" y1="230" x2="110" y2="203" stroke="#000" stroke-width="2"/> <line x1="280" y1="230" x2="330" y2="203" stroke="#000" stroke-width="2"/> <polyline points="110,78 110,203 330,203" fill="none" stroke="#000" stroke-width="1.4" stroke-dasharray="4 4"/> <text x="30" y="172" font-size="13">12 dm</text> <text x="150" y="250" font-size="13">24 dm</text> <text x="300" y="222" font-size="13">10 dm</text> <rect x="420" y="95" width="105" height="135" fill="none" stroke="#000" stroke-width="2"/> <line x1="420" y1="95" x2="462" y2="66" stroke="#000" stroke-width="1.6"/> <line x1="525" y1="95" x2="567" y2="66" stroke="#000" stroke-width="1.6"/> <line x1="525" y1="230" x2="567" y2="201" stroke="#000" stroke-width="1.6"/> <polyline points="462,66 567,66 567,201" fill="none" stroke="#000" stroke-width="1.2" stroke-dasharray="3 3"/> <line x1="462" y1="66" x2="462" y2="95" stroke="#000" stroke-width="1.2" stroke-dasharray="3 3"/> <text x="452" y="252" font-size="13">12 dm</text> <text x="545" y="222" font-size="13">10 dm</text> <text x="575" y="150" font-size="15">?</text> </svg>',
  'hranol-kvadr.svg',
  'Kolmý trojboký hranol s odvěsnami podstavy 12 dm a 24 dm a délkou 10 dm vedle kvádru o rozměrech 12 dm, 10 dm a neznámém rozměru.',
  'Výchozí obrázek k úloze 13',
  new List<String>{'Objem hranolu $=\\frac{1}{2}\\cdot 12\\cdot 24\\cdot 10=1\\,440$ dm³. Objem kvádru $=12\\cdot 10\\cdot x$. Z rovnosti $120x=1\\,440$ plyne $x=12$ dm.'},
  'B) $12$ dm',
  2, 4, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 14',
  new List<String>{'Jeden kilogram jablek byl zlevněn o třetinu ceny. Za $5$ kg zlevněných jablek se tak zaplatí o $18$ Kč méně než za $4$ kg jablek před slevou.','Která z následujících rovnic odpovídá zadání úlohy, jestliže neznámá $x$ představuje cenu za $1$ kg jablek před slevou?'},
  new List<String>{'A) $5\\cdot\\frac{2x}{3}+18=4x$','B) $5x+18=4\\cdot\\frac{4x}{3}$','C) $5\\left(x-\\frac{1}{3}\\right)=4x+18$','D) $5(x-18)=\\frac{2}{3}\\cdot 4x$','E) $5x+18=4\\cdot\\left(x+\\frac{1}{3}\\right)$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Cena po zlevnění o třetinu je $x-\\frac{1}{3}x=\\frac{2}{3}x$. Za $5$ kg zlevněných zaplatíme $5\\cdot\\frac{2x}{3}$, což je o $18$ Kč méně než $4x$ (cena $4$ kg před slevou): $5\\cdot\\frac{2x}{3}=4x-18$, tj. $5\\cdot\\frac{2x}{3}+18=4x$.'},
  'A) $5\\cdot\\frac{2x}{3}+18=4x$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2018 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Číslo $420$ je o $20\\,\\%$ větší než neznámé číslo. Jaké je neznámé číslo?','15.2 $48\\,\\%$ neznámého čísla je o $51$ větší než $33\\,\\%$ téhož neznámého čísla. Jaké je neznámé číslo?','15.3 Poměr dvou čísel je $1:3$. Polovina většího z nich je $135$. Jaký je součet obou čísel?'},
  new List<String>{'A) menší než $320$','B) $320$','C) $340$','D) $350$','E) $360$','F) větší než $360$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 $420=1{,}2\\cdot x\\Rightarrow x=350$ – D.','15.2 $0{,}48x=0{,}33x+51\\Rightarrow 0{,}15x=51\\Rightarrow x=340$ – C.','15.3 Větší číslo $3k$, menší $k$; $\\frac{3k}{2}=135\\Rightarrow k=90$. Čísla $270$ a $90$, součet $360$ – E.'},
  '15.1: D ($350$); 15.2: C ($340$); 15.3: E ($360$)',
  6, 9, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
