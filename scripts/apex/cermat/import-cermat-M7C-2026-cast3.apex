String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD26C0T03';
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
  'CERMAT M7C 2026 – úloha 6',
  new List<String>{'První šestiúhelník se skládá ze dvou shodných bílých rovnostranných trojúhelníků a dvou shodných šedých trojúhelníků. Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek). Nejdelší strana šedého trojúhelníku měří $10$ cm. Obvod prvního šestiúhelníku je $40$ cm a obvod druhého šestiúhelníku je $46$ cm.','6.1 Určete v cm délku jedné strany bílého rovnostranného trojúhelníku.','6.2 Určete v cm obvod šedého trojúhelníku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 320" font-family="sans-serif" font-size="14"> <text x="160" y="120" text-anchor="middle">1. šestiúhelník</text> <polygon points="40,200 120,140 120,260" fill="#ffffff" stroke="#000"/> <polygon points="280,200 200,140 200,260" fill="#ffffff" stroke="#000"/> <polygon points="120,140 200,140 200,260" fill="#bdbdbd" stroke="#000"/> <polygon points="120,140 200,260 120,260" fill="#bdbdbd" stroke="#000"/> <line x1="120" y1="140" x2="200" y2="260" stroke="#000"/> <text x="210" y="205">10 cm</text> <text x="460" y="145" text-anchor="middle">2. šestiúhelník</text> <polygon points="360,260 460,260 360,175" fill="#bdbdbd" stroke="#000"/> <polygon points="460,260 560,260 560,175" fill="#bdbdbd" stroke="#000"/> <polygon points="360,175 460,175 460,260" fill="#ffffff" stroke="#000"/> <polygon points="460,175 560,175 460,260" fill="#ffffff" stroke="#000"/> <text x="390" y="278" text-anchor="middle">10 cm</text> <text x="510" y="278" text-anchor="middle">10 cm</text> </svg>',
  'sestiuhelniky.svg',
  'Dva šestiúhelníky složené ze dvou bílých rovnostranných a dvou šedých trojúhelníků.',
  'Schematický nákres obou šestiúhelníků',
  new List<String>{'Označme stranu bílého rovnostranného trojúhelníku $a$ a nejkratší stranu šedého trojúhelníku $c$; nejdelší strana šedého trojúhelníku je $10$ cm.','Obvod 1. šestiúhelníku tvoří čtyři strany délky $a$ a dvě strany délky $c$: $4a+2c=40$. Obvod 2. šestiúhelníku tvoří dvě strany $a$, dvě strany $c$ a dvě nejdelší strany $10$ cm: $2a+2c+2\\cdot 10=46$, tj. $2a+2c=26$.','Odečtením dostaneme $2a=14$, tedy $a=7$ cm a $c=6$ cm. Strana bílého trojúhelníku je $7$ cm; obvod šedého trojúhelníku je $10+7+6=23$ cm.'},
  '6.1: $7$ cm; 6.2: $23$ cm',
  4, 7, '4',
  new List<String>{'zs2','r7','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2026 – úloha 7',
  new List<String>{'Každá naše tiskárna vytiskne za 2 minuty 54 stran. Každá strana se tiskne stejně dlouhou dobu.','7.1 Vypočtěte, za kolik minut vytiskne jedna tiskárna 135 stran.','7.2 Použili jsme dvě tiskárny společně. Vypočtěte, kolik stran vytiskly obě tiskárny dohromady za 7 minut.','7.3 Použili jsme několik tiskáren společně a dohromady vytiskly za 3 minuty 486 stran. Vypočtěte, kolik tiskáren jsme použili.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Jedna tiskárna vytiskne $54:2=27$ stran za minutu.','7.1 $135:27=5$ minut.','7.2 Dvě tiskárny vytisknou za minutu $2\\cdot 27=54$ stran, za 7 minut $7\\cdot 54=378$ stran.','7.3 Za 3 minuty vytiskne jedna tiskárna $3\\cdot 27=81$ stran; $486:81=6$ tiskáren.'},
  '7.1: $5$ minut; 7.2: $378$ stran; 7.3: $6$ tiskáren',
  4, 7, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
