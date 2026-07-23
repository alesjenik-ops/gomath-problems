String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M9A 2022 – úloha 6',
  new List<String>{'Domeček je vytvořen z pravidelného čtyřbokého hranolu a kolmého trojbokého hranolu. Oba hranoly mají jednu stěnu společnou. Rozměry čtyřbokého hranolu jsou $x$, $x$ a $20$ cm. Podstavou trojbokého hranolu je pravoúhlý trojúhelník s odvěsnami délek $6$ cm a $8$ cm.','Vypočtěte v cm³','6.1 objem trojbokého hranolu,','6.2 objem pravidelného čtyřbokého hranolu.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 300" font-family="sans-serif"> <polygon points="90,230 190,230 190,130 90,130" fill="#f2f2f2" stroke="#000" stroke-width="2"/> <polygon points="90,130 126,82 190,130" fill="#e2e2e2" stroke="#000" stroke-width="2"/> <polyline points="118.8,91.6 128.4,98.8 135.6,89.2" fill="none" stroke="#000" stroke-width="1"/> <line x1="190" y1="230" x2="260" y2="190" stroke="#000" stroke-width="1.5"/> <line x1="260" y1="190" x2="260" y2="90" stroke="#000" stroke-width="1.5"/> <line x1="190" y1="130" x2="260" y2="90" stroke="#000" stroke-width="1.5"/> <line x1="126" y1="82" x2="196" y2="42" stroke="#000" stroke-width="1.5"/> <line x1="196" y1="42" x2="260" y2="90" stroke="#000" stroke-width="1.5"/> <text x="58" y="108" font-size="15">6 cm</text> <text x="150" y="94" font-size="15">8 cm</text> <text x="196" y="188" font-size="15" font-style="italic">x</text> <text x="134" y="252" font-size="15" font-style="italic">x</text> <text x="230" y="224" font-size="15">20 cm</text> </svg>',
  'domecek.svg',
  'Domeček složený z pravidelného čtyřbokého hranolu a kolmého trojbokého hranolu se společnou stěnou; roof odvěsny 6 cm a 8 cm, hrany x, x a 20 cm.',
  'Domeček – čtyřboký a trojboký hranol se společnou stěnou',
  new List<String>{'6.1 Podstava trojbokého hranolu je pravoúhlý trojúhelník s obsahem $\\dfrac{6\\cdot 8}{2}=24$ cm², délka hranolu je $20$ cm, objem $=24\\cdot 20=480$ cm³.','6.2 Společná stěna je čtverec o straně rovné přeponě trojúhelníku $\\sqrt{6^2+8^2}=10$ cm, tedy $x=10$ cm; objem $=10\\cdot 10\\cdot 20=2\\,000$ cm³.'},
  '6.1: $480$ cm³; 6.2: $2\\,000$ cm³',
  3, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 7',
  new List<String>{'Děti i dospělí užívají doporučené dávky vitaminů denně po celý rok. Dle příbalového letáku je doporučená denní dávka vitaminů pro dítě poloviční než pro dospělého. Dva dospělí spotřebují dohromady jedno balení vitaminů za $30$ dní.','Vypočtěte,','7.1 kolik balení vitaminů spotřebuje jeden dospělý za $360$ dní,','7.2 za kolik dní spotřebuje jedno balení vitaminů jedno dítě,','7.3 za kolik dní spotřebují jedno balení vitaminů dohromady dva dospělí a jedno dítě.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Dva dospělí spotřebují balení za $30$ dní, jeden dospělý tedy za $60$ dní; dítě má poloviční dávku, spotřebuje balení za $120$ dní.','7.1 $360:60=6$ balení.','7.2 za $120$ dní.','7.3 Za den spotřebují dva dospělí $\\dfrac{1}{30}$ balení a dítě $\\dfrac{1}{120}$ balení, dohromady $\\dfrac{1}{30}+\\dfrac{1}{120}=\\dfrac{5}{120}=\\dfrac{1}{24}$ balení, tj. jedno balení za $24$ dní.'},
  '7.1: $6$ balení; 7.2: za $120$ dní; 7.3: za $24$ dní',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2022 – úloha 8',
  new List<String>{'Za $4$ dortíky zaplatíme v cukrárně celkem $x$ korun, stejně jako za $5$ koláčů.','8.1 Vyjádřete výrazem s proměnnou $x$, kolik korun zaplatíme v cukrárně za $1$ dortík.','8.2 Vyjádřete výrazem s proměnnou $x$, kolik korun zaplatíme v cukrárně za $4$ koláče.','8.3 V cukrárně jsme za $5$ dortíků a $4$ koláče zaplatili celkem $246$ korun. Vypočtěte, kolik korun jsme zaplatili za jeden dortík.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'8.1 Jeden dortík stojí $\\dfrac{x}{4}$ korun.','8.2 Jeden koláč stojí $\\dfrac{x}{5}$ korun, čtyři koláče tedy $\\dfrac{4}{5}x$ korun.','8.3 $5\\cdot\\dfrac{x}{4}+4\\cdot\\dfrac{x}{5}=246$; $\\dfrac{25x+16x}{20}=246$; $\\dfrac{41x}{20}=246$; $x=120$. Jeden dortík stojí $\\dfrac{120}{4}=30$ korun.'},
  '8.1: $\\dfrac{x}{4}$; 8.2: $\\dfrac{4}{5}x$; 8.3: $30$ korun',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','modelovani','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
