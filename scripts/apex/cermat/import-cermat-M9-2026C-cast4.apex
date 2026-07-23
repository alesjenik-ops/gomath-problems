String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD26C0T03';
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
  'CERMAT M9C 2026 – úloha 8',
  new List<String>{'V náčrtku pravidelného pětiúhelníku $ABCDE$ jsou vyznačeny dvě z jeho os souměrnosti $o_1$, $o_2$, jejich průsečík $S$, úsečka $AD$ a velikosti některých úhlů (viz obrázek). Velikosti úhlů neměřte, ale vypočtěte.','8.1 Vypočtěte ve stupních velikost úhlu $\\varphi$.','8.2 Vypočtěte ve stupních velikost úhlu $\\omega$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 260" font-family="sans-serif"> <polygon points="170,50 265,119 229,231 111,231 75,119" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="111" y1="231" x2="170" y2="50" stroke="#000"/> <line x1="170" y1="50" x2="170" y2="231" stroke="#000"/> <line x1="111" y1="231" x2="232" y2="65" stroke="#000"/> <rect x="164" y="225" width="6" height="6" fill="none" stroke="#000"/> <circle cx="170" cy="150" r="2.5" fill="#000"/> <text x="176" y="150" font-size="13" font-style="italic">S</text> <text x="170" y="44" font-size="13" font-style="italic" text-anchor="middle">D</text> <text x="272" y="120" font-size="13" font-style="italic">C</text> <text x="235" y="245" font-size="13" font-style="italic">B</text> <text x="98" y="245" font-size="13" font-style="italic">A</text> <text x="58" y="120" font-size="13" font-style="italic">E</text> <text x="150" y="82" font-size="14" font-style="italic">ω</text> <text x="182" y="84" font-size="14" font-style="italic">φ</text> <text x="120" y="212" font-size="12">36°</text> <text x="236" y="62" font-size="12" font-style="italic">o₂</text> <text x="176" y="226" font-size="12" font-style="italic">o₁</text> </svg>',
  'petiuhelnik.svg',
  'Pravidelný pětiúhelník ABCDE se dvěma osami souměrnosti, jejich průsečíkem S, úsečkou AD a vyznačenými úhly 36 stupňů, fí a omega.',
  'Náčrt pravidelného pětiúhelníku (ilustrativní)',
  new List<String>{'Vnitřní úhel pravidelného pětiúhelníku má velikost $\\frac{(5-2)\\cdot 180^\\circ}{5}=108^\\circ$, středový úhel je $\\frac{360^\\circ}{5}=72^\\circ$.','8.1 Osa souměrnosti procházející vrcholem $D$ půlí vnitřní úhel při vrcholu $D$, proto $\\varphi=\\frac{108^\\circ}{2}=54^\\circ$.','8.2 Úhel $\\omega$ je polovina středového úhlu, tedy $\\omega=\\frac{72^\\circ}{2}=36^\\circ$ (rovněž $\\omega=90^\\circ-54^\\circ=36^\\circ$).'},
  '8.1: $\\varphi=54^\\circ$; 8.2: $\\omega=36^\\circ$',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2026 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).','Bod $A$ je vrchol rovnoramenného trojúhelníku $ABC$, jehož strany $AC$ a $BC$ mají stejnou délku. Bod $S$ je střed strany $AC$ a na přímce $p$ leží střed $P$ strany $BC$ trojúhelníku $ABC$.','Sestrojte vrchol $C$, střed $P$ a vrchol $B$, označte je písmeny a narýsujte trojúhelník $ABC$. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 280" font-family="sans-serif"> <line x1="40" y1="250" x2="410" y2="95" stroke="#000" stroke-width="1.6"/> <text x="415" y="92" font-size="14" font-style="italic">p</text> <circle cx="110" cy="222" r="2.5" fill="#000"/> <text x="104" y="242" font-size="14" font-style="italic">A</text> <text x="236" y="150" font-size="16" text-anchor="middle">×</text> <text x="230" y="140" font-size="14" font-style="italic">S</text> </svg>',
  'bod-A-S-primka-p.svg',
  'Přímka p procházející bodem A a bod S ležící mimo přímku.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Vrchol $C$ je obraz bodu $A$ ve středové souměrnosti se středem $S$ (S je střed $AC$), tj. $|SC|=|AS|$; tím je $C$ určen.','Trojúhelník je rovnoramenný, $|BC|=|AC|$, a $P$ je střed $BC$, proto $|PC|=\\frac{1}{2}|AC|=|AS|$. Střed $P$ tedy leží na přímce $p$ a zároveň na kružnici se středem $C$ a poloměrem $|AS|$; průsečíky dávají dvě polohy $P_1$, $P_2$.','Vrchol $B$ získáme jako obraz $C$ ve středové souměrnosti se středem $P$ ($|PB|=|PC|$). Úloha má dvě řešení.'},
  'Dvě řešení: $C$ je obraz $A$ podle středu $S$; $P$ je průsečík přímky $p$ s kružnicí ($C$; $|AS|$) – polohy $P_1$, $P_2$; $B$ je obraz $C$ podle středu $P$ (viz obrázek v klíči).',
  3, 8, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
