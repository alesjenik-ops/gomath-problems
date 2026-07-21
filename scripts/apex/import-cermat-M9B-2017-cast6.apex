String SRC   = 'CERMAT – Jednotná přijímací zkouška 2017, 2. řádný termín (M9B)';
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
  'CERMAT 2017 M9B · úloha 13',
  new List<String>{'Krabici tvaru kvádru lze naplnit až po okraj shodnými krychličkami s délkou hrany $2\\ \\mathrm{cm}$. Na dno krabice se do jedné vrstvy naskládá bez mezer $20$ krychliček a takové vrstvy mohou být v krabici nejvýše $4$. Ze zcela naplněné krabice vyjmeme všechny krychličky a vytvoříme z nich jedinou řadu (krychličky přiléhají stěnami za sebou).','Jak dlouhá bude řada?'},
  new List<String>{'A) $0{,}8\\ \\mathrm{m}$','B) $1{,}6\\ \\mathrm{m}$','C) $2{,}0\\ \\mathrm{m}$','D) $2{,}4\\ \\mathrm{m}$','E) delší než $2{,}4\\ \\mathrm{m}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Krabice pojme $20\\cdot4=80$ krychliček. Řada z $80$ krychliček o hraně $2\\ \\mathrm{cm}$ má délku $80\\cdot2=160\\ \\mathrm{cm}=1{,}6\\ \\mathrm{m}$.'},
  'B) $1{,}6\\ \\mathrm{m}$',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky','bezny-zivot'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 14',
  new List<String>{'Krabici tvaru kvádru lze naplnit až po okraj shodnými krychličkami s délkou hrany $2\\ \\mathrm{cm}$. Na dno krabice se do jedné vrstvy naskládá bez mezer $20$ krychliček a takové vrstvy mohou být v krabici nejvýše $4$.','Jaký je objem krabice?'},
  new List<String>{'A) $160\\ \\mathrm{cm}^3$','B) $320\\ \\mathrm{cm}^3$','C) $480\\ \\mathrm{cm}^3$','D) $640\\ \\mathrm{cm}^3$','E) jiný objem'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Krabice pojme $20\\cdot4=80$ krychliček, každá má objem $2^3=8\\ \\mathrm{cm}^3$; objem krabice $80\\cdot8=640\\ \\mathrm{cm}^3$.'},
  'D) $640\\ \\mathrm{cm}^3$',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky','bezny-zivot'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Dvě plné lahve minerálky tvoří $5\\ \\%$ zásob. Kolik plných lahví minerálky tvoří čtvrtinu zásob?','15.2 V autobusu jede $21$ osob. Dětí je mezi nimi o třetinu více než dospělých. Kolik dospělých jede v autobusu?','15.3 Tabulka udává počet žáků v devátých třídách: třída 9.\\,A má $11$ chlapců, $14$ dívek, celkem $25$ žáků; obě deváté třídy mají dohromady $50$ žáků. Mezi všemi žáky obou devátých tříd je $54\\ \\%$ dívek. Kolik chlapců je ve třídě 9.\\,B?','Nabídka: A) méně než $9$; B) $9$; C) $10$; D) $11$; E) $12$; F) více než $12$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $2$ lahve $=5\\ \\%$, tedy $1\\ \\%$ odpovídá $0{,}4$ lahve; čtvrtina $=25\\ \\%$ odpovídá $25\\cdot0{,}4=10$ lahvím — \\textbf{C}.','15.2: je-li dospělých $x$, dětí je $\\frac{4}{3}x$; $x+\\frac{4}{3}x=\\frac{7}{3}x=21\\Rightarrow x=9$ dospělých — \\textbf{B}.','15.3: dívek je $54\\ \\%$ z $50$, tj. $27$; chlapců celkem $50-27=23$; ve třídě 9.\\,B je chlapců $23-11=12$ — \\textbf{E}.'},
  '15.1: C; 15.2: B; 15.3: E',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 16',
  new List<String>{'Dva nebo více shodných obdélníků poskládáme těsně vedle sebe do jedné řady. Pokud se každé dva sousední obdélníky dotýkají kratší stranou, vznikne obrazec typu \\textbf{A}; dotýkají-li se delší stranou, vznikne obrazec typu \\textbf{B}. Platí: obvody obrazců typu \\textbf{A} a \\textbf{B} složených ze dvou obdélníků se liší o $10\\ \\mathrm{cm}$. Přidáme-li k oběma obrazcům další obdélníky, rozdíl mezi obvody obou obrazců se mění.','16.1 Vypočtěte, o kolik cm se liší obvody obrazců \\textbf{A} a \\textbf{B}, obsahuje-li každý z nich tři obdélníky.','16.2 Vypočtěte, o kolik cm se liší obvody obrazců \\textbf{A} a \\textbf{B}, obsahuje-li každý z nich šest obdélníků.','16.3 Obvody obrazců \\textbf{A} a \\textbf{B}, které obsahují stejný počet obdélníků, se liší o $100\\ \\mathrm{cm}$. Vypočtěte, z kolika obdélníků je složen jeden z těchto obrazců.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť má obdélník kratší stranu $a$ a delší stranu $b$. Obrazec typu \\textbf{A} z $n$ obdélníků (spojených kratšími stranami) má obvod $2(nb+a)$; typu \\textbf{B} (spojených delšími stranami) má obvod $2(na+b)$. Jejich rozdíl je $2(nb+a)-2(na+b)=2(n-1)(b-a)$.','Pro $n=2$ je rozdíl $2(b-a)=10\\ \\mathrm{cm}$, tedy $b-a=5\\ \\mathrm{cm}$; obecně je rozdíl $2(n-1)\\cdot5=10(n-1)\\ \\mathrm{cm}$.','16.1: $n=3\\Rightarrow10\\cdot(3-1)=20\\ \\mathrm{cm}$.','16.2: $n=6\\Rightarrow10\\cdot(6-1)=50\\ \\mathrm{cm}$.','16.3: $10(n-1)=100\\Rightarrow n-1=10\\Rightarrow n=11$ obdélníků.'},
  '16.1: $20\\ \\mathrm{cm}$; 16.2: $50\\ \\mathrm{cm}$; 16.3: $11$ obdélníků',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','planimetrie','obvod','algebra','vypocet','slovni','bez-kalkulacky'},
  'M9PBD17C0T02', 2017
);

System.debug('Vytvořeno úloh: '+c.created);
