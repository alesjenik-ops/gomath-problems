String SRC   = 'CERMAT – Přijímací zkoušky 2015, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2015 M9 · úloha 13',
  new List<String>{'Trojúhelník má základnu na přímce. U levého vrcholu je základna prodloužena vlevo; vnější úhel mezi tímto prodloužením a levou stranou trojúhelníku má velikost $90^\\circ+\\alpha$, vnitřní úhel u téhož vrcholu má velikost $\\alpha$. U pravého vrcholu je vnitřní úhel $35^\\circ$, u horního vrcholu je úhel $\\gamma$.','Jaká je velikost úhlu $\\gamma$?'},
  new List<String>{'A) $90^\\circ$','B) $95^\\circ$','C) $100^\\circ$','D) $105^\\circ$','E) jiná velikost'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Vnější úhel $90^\\circ+\\alpha$ a vnitřní úhel $\\alpha$ jsou vedlejší (leží na téže přímce), tedy $(90^\\circ+\\alpha)+\\alpha=180^\\circ$, odkud $2\\alpha=90^\\circ$, $\\alpha=45^\\circ$.','Vnitřní úhly trojúhelníku jsou $45^\\circ$, $35^\\circ$ a $\\gamma$; $\\gamma=180^\\circ-45^\\circ-35^\\circ=100^\\circ$.'},
  'C) $100^\\circ$',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 14',
  new List<String>{'Kružnice je vytvořena z drátu délky $30\\ \\mathrm{cm}$. Z tohoto drátu se vytvaruje obdélník, jehož sousední strany mají délky v poměru $3:2$.','Jaký je obsah obdélníku?'},
  new List<String>{'A) $24\\ \\mathrm{cm}^2$','B) $54\\ \\mathrm{cm}^2$','C) $96\\ \\mathrm{cm}^2$','D) $108\\ \\mathrm{cm}^2$','E) jiný obsah'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Obvod obdélníku je roven délce drátu, tj. $30\\ \\mathrm{cm}$. Strany jsou $3x$ a $2x$: $2(3x+2x)=10x=30\\Rightarrow x=3$.','Strany obdélníku jsou $9\\ \\mathrm{cm}$ a $6\\ \\mathrm{cm}$; obsah $=9\\cdot6=54\\ \\mathrm{cm}^2$.'},
  'B) $54\\ \\mathrm{cm}^2$',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','pomer','vyber','bez-kalkulacky'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 15',
  new List<String>{'Karel s rodiči odlétal na dovolenou. Při odbavení na letišti měla jejich $3$ zavazadla celkovou hmotnost $44\\ \\mathrm{kg}$. Otcovo zavazadlo mělo třikrát větší hmotnost než Karlovo zavazadlo a matčino zavazadlo mělo polovinu hmotnosti otcova zavazadla.','O kolik kilogramů je matčino zavazadlo těžší než Karlovo zavazadlo?'},
  new List<String>{'A) o $3{,}5\\ \\mathrm{kg}$','B) o $4\\ \\mathrm{kg}$','C) o $5\\ \\mathrm{kg}$','D) o $6\\ \\mathrm{kg}$','E) o $6{,}5\\ \\mathrm{kg}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Karlovo zavazadlo $=k$, otcovo $=3k$, matčino $=\\frac{1}{2}\\cdot3k=1{,}5k$.','$k+3k+1{,}5k=5{,}5k=44\\Rightarrow k=8$. Karlovo $8\\ \\mathrm{kg}$, matčino $12\\ \\mathrm{kg}$; rozdíl $12-8=4\\ \\mathrm{kg}$.'},
  'B) o $4\\ \\mathrm{kg}$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','vyber','bez-kalkulacky','bezny-zivot'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 16',
  new List<String>{'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Výrobek stojí $600$ korun. Kolik korun bude stát výrobek zdražený o $20\\ \\%$?','16.2 Kalhoty byly zlevněny o $20\\ \\%$ na $560$ korun. Kolik korun stály kalhoty před zlevněním?','16.3 Zájezd byl zdražen o pětinu na $3\\,600$ korun. O kolik korun byl zájezd zdražen?','Nabídka: A) $600$; B) $650$; C) $672$; D) $700$; E) $720$; F) jiný výsledek.'},
  new List<String>{'A) $600$','B) $650$','C) $672$','D) $700$','E) $720$','F) jiný výsledek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'16.1: $600\\cdot1{,}2=720$ — \\textbf{E}.','16.2: $560=0{,}8\\cdot x\\Rightarrow x=700$ — \\textbf{D}.','16.3: Původní cena $x$: $x+\\frac{1}{5}x=1{,}2x=3\\,600\\Rightarrow x=3\\,000$; zdraženo o $3\\,600-3\\,000=600$ — \\textbf{A}.'},
  '16.1: E; 16.2: D; 16.3: A',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 17',
  new List<String>{'V motorestu se podávají tři různé večeře $A$, $B$, $C$. Přijely tři $20$členné skupiny. Pro každou skupinu je uvedeno, kolik večeří jednotlivých druhů si objednala, a jaká byla průměrná cena večeře ve skupině:','Skupina 1: $20\\times A$, $0\\times B$, $0\\times C$; průměrná cena $200$ Kč.','Skupina 2: $10\\times A$, $10\\times B$, $0\\times C$; průměrná cena $240$ Kč.','Skupina 3: $5\\times A$, $5\\times B$, $10\\times C$; průměrná cena $270$ Kč.','17.1 Vypočtěte cenu večeře $B$.','17.2 Vypočtěte cenu večeře $C$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Ze skupiny 1 (samé $A$, průměr $200$) plyne cena $A=200$ Kč.','17.1: Skupina 2: $\\frac{10\\cdot200+10\\cdot B}{20}=240\\Rightarrow2\\,000+10B=4\\,800\\Rightarrow B=280$ Kč.','17.2: Skupina 3: $\\frac{5\\cdot200+5\\cdot280+10\\cdot C}{20}=270\\Rightarrow2\\,400+10C=5\\,400\\Rightarrow C=300$ Kč.'},
  '17.1: $280$ Kč; 17.2: $300$ Kč',
  4, 7, '4',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PZD15C0T01', 2015
);

System.debug('Vytvořeno úloh: '+c.created);
