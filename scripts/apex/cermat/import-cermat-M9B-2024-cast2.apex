String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD24C0T02';
Integer YEAR = 2024;

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
  'CERMAT M9B 2024 - uloha 5.1',
  new List<String>{'Reste rovnici (zkousku nezapisujte). Uvedte cely postup reseni.','$1{,}6:2-\\frac{x}{2}=3\\cdot 0{,}7x+3{,}4$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}6:2-\\frac{x}{2}=3\\cdot 0{,}7x+3{,}4$, tj. $0{,}8-0{,}5x=2{,}1x+3{,}4$. Odtud $0{,}8-3{,}4=2{,}1x+0{,}5x$, tedy $-2{,}6=2{,}6x$ a $x=-1$.'},
  '$x=-1$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 5.2',
  new List<String>{'Reste rovnici (zkousku nezapisujte). Uvedte cely postup reseni.','$\\frac{5-2y}{3}+\\frac{y}{9}=\\frac{3-y}{6}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Rovnici vynasobime $18$: $6(5-2y)+2y=3(3-y)$, tj. $30-12y+2y=9-3y$, $30-10y=9-3y$, $21=7y$, $y=3$.'},
  '$y=3$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 6',
  new List<String>{'Ctyruhelnik $ABCD$ je takovy lichobeznik se zakladnami $AB$ a $CD$, ze usecka $BD$ je jeho vyska. Pro delky stran plati $|AD|=17$ cm, $|BD|=8$ cm, obsah trojuhelniku $BCD$ je $S_{BCD}=24$ cm$^2$.','6.1 Vypocitejte obsah lichobezniku $ABCD$. Vysledek uvedte v cm$^2$.','6.2 Vypocitejte obvod lichobezniku $ABCD$. Vysledek uvedte v cm.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 280" font-family="sans-serif"> <polygon points="60,220 320,220 430,80 320,80" fill="none" stroke="#000" stroke-width="2"/> <line x1="320" y1="220" x2="320" y2="80" stroke="#000" stroke-width="1.5" stroke-dasharray="5 5"/> <rect x="304" y="204" width="16" height="16" fill="none" stroke="#000"/> <text x="46" y="236" font-size="16" font-style="italic">A</text> <text x="322" y="238" font-size="16" font-style="italic">B</text> <text x="436" y="76" font-size="16" font-style="italic">C</text> <text x="304" y="72" font-size="16" font-style="italic">D</text> </svg>',
  'lichobeznik-abcd.svg',
  'Lichobeznik ABCD se zakladnami AB a CD a uhloprickou BD, ktera je vyskou a svira s AB pravy uhel.',
  'Lichobeznik ABCD (schematicky nakres)',
  new List<String>{'6.1 Trojuhelnik $ABD$ ma pravy uhel u $B$: $|AB|=\\sqrt{17^2-8^2}=\\sqrt{225}=15$ cm. Z $S_{BCD}=\\frac{1}{2}\\cdot|CD|\\cdot|BD|=24$ plyne $|CD|=\\frac{2\\cdot 24}{8}=6$ cm. Obsah lichobezniku: $\\frac{|AB|+|CD|}{2}\\cdot|BD|=\\frac{15+6}{2}\\cdot 8=84$ cm$^2$.','6.2 $|BC|=\\sqrt{|CD|^2+|BD|^2}=\\sqrt{6^2+8^2}=10$ cm. Obvod: $|AB|+|BC|+|CD|+|DA|=15+10+6+17=48$ cm.'},
  '6.1: $84$ cm$^2$; 6.2: $48$ cm',
  4, 7, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 7',
  new List<String>{'Petr sbira modely aut. Druhy rok nasbiral o polovinu poctu modelu aut vice, nez ktere nasbiral prvni rok. Treti rok nasbiral $72$ modelu. Pocet modelu, ktere Petr nasbiral v prvnim roce, oznacte $x$.','7.1 V zavislosti na velicine $x$ vyjadrete, kolik modelu nasbiral Petr behem druheho roku.','7.2 Vypocitejte, kolik modelu nasbiral Petr behem prvniho roku, pokud za tri roky nasbiral $217$ modelu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 Druhy rok nasbiral o polovinu vice nez prvni rok ($x$): $x+\\frac{1}{2}x=1{,}5x$.','7.2 Za tri roky: $x+1{,}5x+72=217$, tj. $2{,}5x=145$, tedy $x=58$ modelu.'},
  '7.1: $1{,}5x$; 7.2: $58$ modelu',
  4, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
