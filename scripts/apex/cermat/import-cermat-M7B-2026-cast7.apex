String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD26C0T02';
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
  'CERMAT M7B 2026 – úloha 15',
  new List<String>{'V divadelním sále je celkem 300 míst. Při večerním představení obsadili muži 108 míst, ženy 120 míst a ostatní místa zůstala neobsazena.','Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).','15.1 Kolik procent všech míst zůstalo při večerním představení neobsazeno?','15.2 Všechna obsazená místa byla zaplacena. Kromě nich byla zaplacena ještě jedna šestina neobsazených míst, neboť někteří předplatitelé kvůli nemoci nepřišli. Kolik procent všech míst nebylo na večerním představení zaplaceno?','15.3 O kolik procent méně bylo na večerním představení mužů než žen?'},
  new List<String>{'A) $10\\,\\%$','B) $15\\,\\%$','C) $18\\,\\%$','D) $20\\,\\%$','E) $24\\,\\%$','F) jiný počet procent'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Neobsazená místa: $300 - 108 - 120 = 72$.','15.1 $\\frac{72}{300} = 24\\,\\%$ míst zůstalo neobsazeno → E.','15.2 Zaplaceno bylo $228$ obsazených míst a navíc šestina neobsazených, tj. $\\frac{72}{6} = 12$ míst; celkem $240$. Nezaplaceno zůstalo $300 - 240 = 60$ míst, tj. $\\frac{60}{300} = 20\\,\\%$ → D.','15.3 Mužů bylo o $120 - 108 = 12$ méně než žen, tj. $\\frac{12}{120} = 10\\,\\%$ → A.'},
  '15.1: E ($24\\,\\%$); 15.2: D ($20\\,\\%$); 15.3: A ($10\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2026 – úloha 16',
  new List<String>{'V počítačové hře se vyměňují desky, prkna a tyče pouze podle následujících pravidel: jednu desku lze vyměnit za 4 prkna; libovolnou dvojici prken lze vyměnit za 5 tyčí. Z vyměněných dílů vytváříme ohradu: na 1 kus ohrady potřebujeme 3 prkna a 2 tyče. K dispozici máme pouze desky a postupně je měníme za díly k ohradě.','16.1 Určete, kolik nejméně desek potřebujeme na 3 kusy ohrady.','16.2 Celkem 6 desek použijeme k vytvoření co největšího počtu kusů ohrady. Určete, které nepoužité díly nám zbudou a v jakém počtu.','16.3 Máme k dispozici 19 desek. Určete, kolik nejvíce kusů ohrady můžeme vytvořit.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 210" font-family="sans-serif" font-size="12"> <rect x="20" y="20" width="70" height="34" fill="#d8d8d8" stroke="#000"/> <text x="110" y="42" font-size="18">to</text> <rect x="150" y="16" width="40" height="16" fill="#d8d8d8" stroke="#000"/> <rect x="200" y="16" width="40" height="16" fill="#d8d8d8" stroke="#000"/> <rect x="150" y="40" width="40" height="16" fill="#d8d8d8" stroke="#000"/> <rect x="200" y="40" width="40" height="16" fill="#d8d8d8" stroke="#000"/> <text x="260" y="42" font-size="12">1 deska = 4 prkna</text> <rect x="20" y="90" width="40" height="16" fill="#d8d8d8" stroke="#000"/> <rect x="66" y="90" width="40" height="16" fill="#d8d8d8" stroke="#000"/> <text x="120" y="102" font-size="18">to</text> <rect x="150" y="80" width="90" height="6" fill="#c8c8c8" stroke="#000"/> <rect x="150" y="90" width="90" height="6" fill="#c8c8c8" stroke="#000"/> <rect x="150" y="100" width="90" height="6" fill="#c8c8c8" stroke="#000"/> <rect x="150" y="110" width="90" height="6" fill="#c8c8c8" stroke="#000"/> <rect x="150" y="120" width="90" height="6" fill="#c8c8c8" stroke="#000"/> <text x="260" y="102" font-size="12">2 prkna = 5 tyčí</text> <text x="20" y="165" font-size="12">1 kus ohrady = 3 prkna + 2 tyče</text> </svg>',
  'hra-dily.svg',
  'Pravidla výměny: 1 deska za 4 prkna, 2 prkna za 5 tyčí; 1 kus ohrady je z 3 prken a 2 tyčí.',
  'Schematický nákres pravidel výměny dílů',
  new List<String>{'Pravidla: $1$ deska $= 4$ prkna, $2$ prkna $= 5$ tyčí, $1$ kus ohrady $= 3$ prkna $+ 2$ tyče.','16.1 Na $3$ kusy ohrady je potřeba $9$ prken (přímo) a $6$ tyčí. Na $6$ tyčí je nutné vyměnit $4$ prkna (dvě výměny po $5$ tyčích dávají $10$ tyčí). Celkem $9 + 4 = 13$ prken; $3$ desky dají jen $12$ prken, proto jsou potřeba $4$ desky ($16$ prken).','16.2 Z $6$ desek je $24$ prken. Nejvíce vznikne $6$ kusů ohrady: $18$ prken přímo a $6$ prken vyměníme za $15$ tyčí ($3$ výměny). Ohrady spotřebují $6 \\cdot 2 = 12$ tyčí, zbudou tedy $3$ tyče (prkna i desky se spotřebují beze zbytku).','16.3 Z $19$ desek je $76$ prken. Pro $n$ kusů ohrady je potřeba $3n$ prken přímo a na $2n$ tyčí další výměny po $2$ prknech. Pro $n = 20$: $60 + 16 = 76$ prken (přesně vychází); $n = 21$ by vyžadovalo $81$ prken. Nejvíce lze vytvořit $20$ kusů ohrady.'},
  '16.1: $4$ desky; 16.2: zbudou $3$ tyče; 16.3: $20$ kusů ohrady',
  4, 8, '4',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
