String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD25C0T04';
Integer YEAR = 2025;

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
  'CERMAT M9D 2025 – úloha 6',
  new List<String>{'Na odvoz beden ze skladu se používají dva různí roboti A, B. Ve skladu bylo $95$ beden. Bedny nejprve odvážel robot A, a to po $5$ kusech; jezdil v pravidelných intervalech a odvezl ze skladu za $2$ hodiny celkem $50$ beden. Pak pokračoval robot B, který vozil bedny jen po $3$ kusech, avšak v kratších pravidelných intervalech; odvezl tak ze skladu za $1{,}5$ hodiny zbývajících $45$ beden.','6.1 Vyjádřete v základním tvaru poměr počtu beden odvezených ze skladu za $1$ hodinu robotem A ku počtu beden odvezených za $1$ hodinu robotem B.','6.2 Vyjádřete v základním tvaru poměr počtu jízd robota A za hodinu ku počtu jízd robota B za hodinu.','6.3 Vypočtěte, kolik beden by ze skladu odvezli za $36$ minut oba roboti dohromady při společném provozu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Robot A: $50$ beden za $2$ h $=25$ beden/h; robot B: $45$ beden za $1{,}5$ h $=30$ beden/h. Poměr $25:30=5:6$.','6.2 Robot A jezdí po $5$ kusech: $25:5=5$ jízd/h; robot B po $3$ kusech: $30:3=10$ jízd/h. Poměr $5:10=1:2$.','6.3 Za $36$ min $=0{,}6$ h odvezou dohromady $(25+30)\\cdot 0{,}6=55\\cdot 0{,}6=33$ beden.'},
  '6.1: $5:6$; 6.2: $1:2$; 6.3: $33$ beden',
  4, 7, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2025 – úloha 7',
  new List<String>{'Do vědomostní soutěže se přihlásilo $10$ soutěžících a všichni se zúčastnili $1.$ i $2.$ kola. V každém kole získali jednotliví soutěžící $8$, $9$, nebo $10$ bodů. Některé údaje jsou v tabulce.','7.1 V $1.$ kole bylo soutěžících, kteří získali $8$ bodů, o jednoho méně než těch, kteří získali $10$ bodů. Určete průměrný bodový zisk všech soutěžících v $1.$ kole.','7.2 Určete, kolik soutěžících mohlo ve $2.$ kole získat $9$ bodů. Najděte všechna řešení.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 450 128" font-family="sans-serif"> <rect x="10" y="10" width="430" height="108" fill="none" stroke="#000" stroke-width="1.2"/> <line x1="90" y1="10" x2="90" y2="118" stroke="#000"/> <line x1="330" y1="10" x2="330" y2="118" stroke="#000"/> <line x1="170" y1="38" x2="170" y2="118" stroke="#000"/> <line x1="250" y1="38" x2="250" y2="118" stroke="#000"/> <line x1="90" y1="38" x2="330" y2="38" stroke="#000"/> <line x1="10" y1="66" x2="440" y2="66" stroke="#000"/> <line x1="10" y1="92" x2="440" y2="92" stroke="#000"/> <text x="210" y="28" font-size="11" text-anchor="middle">Počet soutěžících, kteří získali</text> <text x="130" y="55" font-size="11" text-anchor="middle">8 bodů</text> <text x="210" y="55" font-size="11" text-anchor="middle">9 bodů</text> <text x="290" y="55" font-size="11" text-anchor="middle">10 bodů</text> <text x="385" y="25" font-size="11" text-anchor="middle">Aritmetický</text> <text x="385" y="39" font-size="11" text-anchor="middle">průměr počtu bodů</text> <text x="50" y="83" font-size="11" text-anchor="middle">1. kolo</text> <text x="50" y="109" font-size="11" text-anchor="middle">2. kolo</text> <text x="210" y="83" font-size="11" text-anchor="middle">5</text> <text x="385" y="109" font-size="11" text-anchor="middle">9,5</text> </svg>',
  'tabulka-soutez.svg',
  'Tabulka: počty soutěžících podle bodů (8, 9, 10) a aritmetický průměr; v 1. kole je u 9 bodů hodnota 5, ve 2. kole je průměr 9,5.',
  'Výsledky vědomostní soutěže',
  new List<String>{'7.1 Počty soutěžících v $1.$ kole: $8$ b. $=a$, $9$ b. $=5$, $10$ b. $=c$; platí $a+5+c=10$ a $a=c-1$, odtud $c=3$, $a=2$. Průměr $=\\dfrac{8\\cdot 2+9\\cdot 5+10\\cdot 3}{10}=\\dfrac{91}{10}=9{,}1$ bodu.','7.2 Ve $2.$ kole je průměr $9{,}5$, tj. celkem $95$ bodů od $10$ soutěžících. Z $x_8+x_9+x_{10}=10$ a $8x_8+9x_9+10x_{10}=95$ plyne $x_9\\in\\{1,3,5\\}$ (pro $x_{10}=7,6,5$). Devět bodů tedy mohlo získat $1$, $3$, nebo $5$ soutěžících.'},
  '7.1: $9{,}1$ bodu; 7.2: $1$, $3$, nebo $5$ soutěžících',
  4, 8, '4',
  new List<String>{'zs2','r9','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
