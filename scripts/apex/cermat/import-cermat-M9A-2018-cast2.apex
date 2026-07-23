String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD18C0T01';
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
  'CERMAT M9A 2018 – úloha 6',
  new List<String>{'Čtenáři si v knihovně během prvních tří dnů půjčili celkem $220$ knih. Druhý den si čtenáři půjčili o polovinu více knih než první den a zároveň o $20$ knih méně než třetí den.','Neznámý počet knih, které si čtenáři půjčili v knihovně první den, označte $x$.','6.1 V závislosti na veličině $x$ vyjádřete počet knih, které si čtenáři půjčili druhý den.','6.2 V závislosti na veličině $x$ vyjádřete počet knih, které si čtenáři půjčili třetí den.','6.3 Vypočtěte, kolik knih si čtenáři půjčili první den.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Druhý den o polovinu více než první den: $x+\\frac{1}{2}x=1{,}5x$.','6.2 Druhý den je o $20$ knih méně než třetí, třetí den tedy $1{,}5x+20$.','6.3 Součet tří dnů: $x+1{,}5x+(1{,}5x+20)=220$, odtud $4x+20=220$, $4x=200$, $x=50$.'},
  '6.1: $1{,}5x$; 6.2: $1{,}5x+20$; 6.3: $50$ knih',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2018 – úloha 7',
  new List<String>{'Papírový obdélník s rozměry $18$ cm $\\times$ $5$ cm se beze zbytku použije na zhotovení kvádru. Obdélník se rozstříhá na jednotlivé stěny kvádru (tj. podstavy i boční stěny). Stříhat se smí jen v naznačeném směru – rovnoběžném s kratší stranou původního obdélníku. Z nastříhaných stěn se složí kvádr tak, aby se papír nikde nepřekrýval, a po hranách se spojí lepicí páskou.','Vypočtěte:','7.1 v cm² povrch složeného kvádru;','7.2 v cm rozměry kvádru (existuje jediné možné řešení);','7.3 v cm³ objem složeného kvádru.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 150" font-family="sans-serif"> <rect x="30" y="45" width="252" height="70" fill="#eeeeee" stroke="#000" stroke-width="2"/> <line x1="240" y1="45" x2="240" y2="115" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <text x="156" y="134" font-size="13" text-anchor="middle">18 cm</text> <text x="292" y="84" font-size="13">5 cm</text> <text x="250" y="30" font-size="11" text-anchor="middle">směr stříhání</text> <line x1="255" y1="48" x2="255" y2="72" stroke="#000" stroke-width="1"/> <polygon points="255,74 251,66 259,66" fill="#000"/> </svg>',
  'kvadr-papir.svg',
  'Papírový obdélník 18 cm krát 5 cm s vyznačeným směrem stříhání rovnoběžným s kratší stranou.',
  'Výchozí obrázek k úloze 7 (papírový obdélník)',
  new List<String>{'7.1 Papír se použije beze zbytku a nikde se nepřekrývá, povrch kvádru se proto rovná obsahu obdélníku: $18\\cdot 5=90$ cm².','7.2 Stříhá se rovnoběžně s kratší stranou, jeden rozměr kvádru je proto $5$ cm. Kvádr s povrchem $90$ cm² má rozměry $5\\times 5\\times 2$ cm, neboť $2(5\\cdot 5+5\\cdot 2+5\\cdot 2)=90$.','7.3 Objem $5\\cdot 5\\cdot 2=50$ cm³.'},
  '7.1: $90$ cm²; 7.2: $5$ cm, $5$ cm, $2$ cm; 7.3: $50$ cm³',
  3, 6, '4',
  new List<String>{'zs2','r9','stereometrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2018 – úloha 8.1',
  new List<String>{'Vypočtěte v minutách devítinu úhlu o velikosti $7{,}5$ stupně.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$7{,}5^\\circ=7{,}5\\cdot 60=450$ úhlových minut. Devítina je $450:9=50$ minut.'},
  '$50$ minut',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 8.2',
  new List<String>{'Vypočtěte v cm² obsah trojúhelníku $ABC$, je-li obsah rovnoběžníku $ABCD$ $1{,}5$ dm².'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Obsah rovnoběžníku $1{,}5$ dm² $=150$ cm². Trojúhelník $ABC$ je polovina rovnoběžníku $ABCD$, tedy $150:2=75$ cm².'},
  '$75$ cm²',
  1, 2, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 8.3',
  new List<String>{'Vypočtěte, kolikrát je objem $0{,}2$ litru větší než objem $5$ mililitrů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}2$ litru $=200$ ml. Podíl $200:5=40$, objem je tedy $40$krát větší.'},
  '$40$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
