String SRC   = 'CERMAT – Ilustrační test 2021, matematika 9 (čtyřleté obory)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2021 M9I · úloha 15',
  new List<String>{'Ve městě jsou tři střední školy. Na školu X se přihlásilo $450$ žáků; přihlášených žáků bylo o $150\\ \\%$ více než přijatých. Na školu Y se přihlásilo o $50\\ \\%$ více žáků než na školu X a bylo přijato $40\\ \\%$ přihlášených žáků. Na školu Z se přihlásilo $300$ žáků, což je o třetinu žáků více, než na ni bylo přijato.','Přiřaďte ke každé otázce (15.1–15.3) odpovídající odpověď (A–F).','15.1 \\quad Kolik žáků bylo přijato na školu X?','15.2 \\quad Kolik žáků bylo přijato na školu Y?','15.3 \\quad Kolik žáků bylo přijato na školu Z?','Nabídka: A) $180$; B) $200$; C) $225$; D) $270$; E) $300$; F) jiný počet.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $450$ je $250\\ \\%$ přijatých, tedy přijato $\\frac{450}{2{,}5}=180$ — \\textbf{A}.','15.2: přihlášeno $450\\cdot1{,}5=675$; přijato $0{,}4\\cdot675=270$ — \\textbf{D}.','15.3: $300=\\frac{4}{3}\\cdot$ přijatých, tedy přijato $300\\cdot\\frac{3}{4}=225$ — \\textbf{C}.'},
  '15.1: A; 15.2: D; 15.3: C',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 16',
  new List<String>{'Čtvercová deska má v každé řadě i v každém sloupci $15$ polí. V prvním tahu se položí jeden žeton na prostřední pole desky. Ve druhém a každém dalším tahu se položí po jednom žetonu na všechna neobsazená pole, která svou stranou sousedí s poli obsazenými žetony v předchozích tazích. Teprve po posledním tahu bude ležet na každém poli desky jeden žeton.','Obsazená pole tvoří „kosočtverec“: bezprostředně po $n$-tém tahu jsou obsazena právě všechna pole, jejichž vzdálenost od prostředního pole (počítáno po krocích vodorovně a svisle) je nejvýše $n-1$.','Určete,','16.1 \\quad kolik žetonů bude celkem na desce bezprostředně po pátém tahu,','16.2 \\quad kolik žetonů se na desku položí v posledním tahu,','16.3 \\quad kolik neobsazených polí bude na desce bezprostředně po $12.$ tahu.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Počet obsazených polí do vzdálenosti $r$ je $2r^2+2r+1$ (dokud kosočtverec nepřesahuje okraj $15\\times15$ desky).','16.1: po $5.$ tahu je $r=4$: $2\\cdot16+2\\cdot4+1=41$ žetonů.','16.2: přepona/rohy jsou ve vzdálenosti $7+7=14$ od středu, poslední je $15.$ tah. V $15.$ tahu se obsadí jen $4$ rohová pole (jediná ve vzdálenosti $14$): $4$ žetony.','16.3: neobsazená po $12.$ tahu jsou pole ve vzdálenosti $\\ge12$. Pro vzdálenosti $12,13,14$ (souřadnice omezené na $\\pm7$) jich je $12+8+4=24$ polí.'},
  '16.1: $41$ žetonů; 16.2: $4$ žetony; 16.3: $24$ polí',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','aritmetika','uvazovani','slovni','bez-kalkulacky'},
  'M9PID21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
