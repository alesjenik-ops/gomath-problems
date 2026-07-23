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
  'CERMAT M9C 2026 – úloha 5',
  new List<String>{'Do fitcentra mají přístup členové klubu i běžní návštěvníci. Člen klubu zaplatí fitcentru na začátku každého roku jednorázový poplatek 600 korun a za každý vstup platí 120 korun. Běžný návštěvník platí fitcentru za každý vstup 160 korun. Tereza je členkou klubu. Mirek členem klubu není, a platí tedy běžné vstupné. Počet Tereziných letošních vstupů do fitcentra označíme $x$.','5.1 Vyjádřete výrazem s proměnnou $x$, kolik korun Tereza letos celkem zaplatila fitcentru.','5.2 Tereza s Mirkem navštěvují fitcentrum vždy společně. Mirek zaplatil letos za všechny vstupy dohromady stejnou částku, jakou fitcentru letos celkem zaplatila Tereza. Vypočtěte, kolikrát Tereza letos navštívila fitcentrum.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Tereza platí poplatek 600 korun a za každý z $x$ vstupů 120 korun, celkem $120x+600$ korun.','5.2 Mirek chodí stejně často jako Tereza ($x$ vstupů) a platí 160 korun za vstup, tj. $160x$ korun. Z rovnosti $160x=120x+600$ plyne $40x=600$, tedy $x=15$. Tereza navštívila fitcentrum 15krát.'},
  '5.1: $120x+600$ (korun); 5.2: 15krát',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9C 2026 – úloha 6',
  new List<String>{'První šestiúhelník se skládá ze dvou shodných bílých rovnostranných trojúhelníků a dvou shodných šedých trojúhelníků. Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek). Nejdelší strana šedého trojúhelníku měří 10 cm. Obvod prvního šestiúhelníku je 40 cm a obvod druhého šestiúhelníku je 46 cm.','6.1 Určete v cm délku jedné strany bílého rovnostranného trojúhelníku.','6.2 Určete v cm obvod šedého trojúhelníku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 215" font-family="sans-serif"> <text x="140" y="20" font-size="13" text-anchor="middle">1. sestiuhelnik</text> <polygon points="90,55 190,55 90,185" fill="#c4c4c4" stroke="#000"/> <polygon points="190,55 190,185 90,185" fill="#c4c4c4" stroke="#000"/> <polygon points="30,120 90,55 90,185" fill="#ffffff" stroke="#000"/> <polygon points="250,120 190,55 190,185" fill="#ffffff" stroke="#000"/> <polygon points="30,120 90,55 190,55 250,120 190,185 90,185" fill="none" stroke="#000" stroke-width="1.5"/> <text x="150" y="128" font-size="12">10 cm</text> <text x="420" y="20" font-size="13" text-anchor="middle">2. sestiuhelnik</text> <polygon points="320,185 420,185 370,95" fill="#c4c4c4" stroke="#000"/> <polygon points="420,185 520,185 470,95" fill="#c4c4c4" stroke="#000"/> <polygon points="370,95 470,95 420,185" fill="#ffffff" stroke="#000"/> <polygon points="370,95 470,95 420,30" fill="#ffffff" stroke="#000"/> <text x="352" y="200" font-size="12">10 cm</text> <text x="452" y="200" font-size="12">10 cm</text> </svg>',
  'sestiuhelniky.svg',
  'Dva šestiúhelníky složené ze dvou bílých rovnostranných a dvou šedých trojúhelníků; nejdelší strana šedého trojúhelníku je 10 cm.',
  'Schematický nákres (1. a 2. šestiúhelník)',
  new List<String>{'Ze zadaných obvodů obou šestiúhelníků (40 cm a 46 cm) a přeskládání týchž čtyř trojúhelníků vychází, že bílý rovnostranný trojúhelník má stranu 7 cm a šedý trojúhelník má strany 10 cm, 7 cm a 6 cm.','6.1 Strana bílého rovnostranného trojúhelníku je 7 cm.','6.2 Obvod šedého trojúhelníku je $10+7+6=23$ cm.'},
  '6.1: 7 cm; 6.2: 23 cm',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
