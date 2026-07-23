String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD23C0T02';
Integer YEAR = 2023;

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
  'CERMAT M5B 2023 – úloha 13',
  new List<String>{'V každém diagramu se stejné symboly nahradí stejným kladným celým číslem a do prázdného oválu se doplní takové celé číslo, aby byly všechny výpočty ve směru šipek správné. Vzor: z čísla $20$ vznikne šipkou $\\cdot\\,\\ast+10$ číslo $50$ a další šipkou $:\\ast-\\ast$ prázdný ovál; pro $\\ast=2$ se do oválu doplní $23$ (neboť $50:2-2=23$).','13.1 Z čísla $4$ vznikne šipkou $\\cdot\\,\\bullet\\cdot\\,\\bullet$ číslo $100$ a další šipkou $:4-2\\cdot\\bullet$ prázdný ovál.','13.2 Z prázdného oválu vznikne šipkou $:\\star+\\star$ číslo $10$ a další šipkou $\\cdot\\,\\star-\\star$ číslo $72$.','13.3 Z čísla $480$ vznikne šipkou $:\\odot-10$ prázdný ovál a další šipkou $\\cdot\\,10-\\odot$ číslo $120$.','Přiřaďte ke každému diagramu (13.1–13.3) číslo (A–F) doplněné do prázdného oválu.'},
  new List<String>{'A) 13','B) 14','C) 15','D) 16','E) 17','F) jiné číslo'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'13.1 $4\\cdot\\bullet\\cdot\\bullet=100\\Rightarrow \\bullet^2=25\\Rightarrow \\bullet=5$; ovál $=100:4-2\\cdot 5=25-10=15$ — C.','13.2 $10\\cdot\\star-\\star=72\\Rightarrow 9\\star=72\\Rightarrow \\star=8$; do počátečního oválu patří $(10-8)\\cdot 8=2\\cdot 8=16$ — D.','13.3 Prostřední ovál $=480:\\odot-10$ a $(480:\\odot-10)\\cdot 10-\\odot=120\\Rightarrow \\odot^2+220\\odot-4800=0\\Rightarrow \\odot=20$; ovál $=480:20-10=14$ — B.'},
  '13.1: C ($15$); 13.2: D ($16$); 13.3: B ($14$)',
  5, 6, '4',
  new List<String>{'zs1','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2023 – úloha 14',
  new List<String>{'Základním dílkem je 1. obdélník rozdělený na jeden bílý čtvereček a šest stejně velkých trojúhelníků; bílé trojúhelníky přiléhají ke kratším stranám obdélníku, šedé k delším stranám. Spojováním základních dílků vytváříme větší obdélníky podle pravidel: k sobě přiléhají pouze trojúhelníky téže barvy a jejich spojením vznikají další čtverečky; delší strana obdélníku je vždy dvakrát delší než kratší strana; v 1. obdélníku přiléhá ke kratší straně jeden bílý trojúhelník a v každém dalším obdélníku vždy o jeden bílý trojúhelník více než v předchozím (viz obrázek). 2. obdélník obsahuje 6 bílých a 4 šedé čtverečky.','14.1 Určete, kolik čtverečků (bílých i šedých dohromady) obsahuje 4. obdélník.','14.2 Určete, kolik šedých čtverečků obsahuje obdélník se 45 bílými čtverečky.','14.3 Určete, kolik bílých čtverečků obsahuje obdélník, ve kterém je bílých čtverečků o 7 více než šedých.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 160" font-family="sans-serif"> <g stroke="#000" stroke-width="1.2" fill="#cfcfcf"> <rect x="30" y="55" width="40" height="24"/> <rect x="120" y="45" width="80" height="40"/> <rect x="250" y="35" width="120" height="56"/> </g> <g stroke="#000" stroke-width="0.8"> <line x1="30" y1="55" x2="70" y2="79"/><line x1="70" y1="55" x2="30" y2="79"/> <line x1="120" y1="45" x2="200" y2="85"/><line x1="200" y1="45" x2="120" y2="85"/> <line x1="160" y1="45" x2="160" y2="85"/> <line x1="250" y1="35" x2="370" y2="91"/><line x1="370" y1="35" x2="250" y2="91"/> <line x1="290" y1="35" x2="290" y2="91"/><line x1="330" y1="35" x2="330" y2="91"/> </g> <text x="398" y="70" font-size="26">...</text> <g font-size="12" text-anchor="middle"> <text x="50" y="98">1. obdélník</text> <text x="160" y="104">2. obdélník</text> <text x="160" y="120">(6 bílých a 4 šedé čtverečky)</text> <text x="310" y="108">3. obdélník</text> </g> </svg>',
  'obdelniky-14.svg',
  'První, druhý a třetí obdélník sestavené z bílých a šedých trojúhelníků a čtverečků, rostoucí velikosti.',
  'Schematický nákres 1., 2. a 3. obdélníku',
  new List<String>{'V $n$-tém obdélníku je bílých čtverečků $B=2n^2-n$ a šedých $G=2n^2-2n$ (pro $n=2$: $B=6$, $G=4$); celkem $B+G=4n^2-3n$ a rozdíl $B-G=n$.','14.1 Pro $n=4$: $4\\cdot 4^2-3\\cdot 4=64-12=52$ čtverečků.','14.2 Z $2n^2-n=45$ plyne $n=5$; šedých je $G=2\\cdot 25-10=40$.','14.3 $B-G=n=7$, tedy $n=7$; bílých je $B=2\\cdot 49-7=91$.'},
  '14.1: $52$ čtverečků; 14.2: $40$ šedých čtverečků; 14.3: $91$ bílých čtverečků',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
