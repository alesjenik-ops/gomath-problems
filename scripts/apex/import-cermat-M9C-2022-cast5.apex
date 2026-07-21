String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, náhradní termín (M9C)';
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
  'CERMAT 2022 M9C · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 \\quad Když firma odvezla do spalovny $60\\ \\%$ odpadu, zbylo jí ještě $1\\,200\\ \\mathrm{kg}$ odpadu. Kolik kg odpadu firma odvezla do spalovny?','15.2 \\quad Stejné dlaždice byly umístěny ve stejném počtu na dvou paletách. Již se prodaly dvě pětiny dlaždic z první palety a $10\\ \\%$ dlaždic z druhé palety. Hmotnost všech těchto prodaných dlaždic byla $750\\ \\mathrm{kg}$. Kolik kg váží dosud neprodané dlaždice z obou palet?','15.3 \\quad Ve sběrných surovinách vykoupili v létě $1\\,500\\ \\mathrm{kg}$ kovů, což je o $50\\ \\%$ více než na jaře a o $50\\ \\%$ méně než na podzim. O kolik kg kovů vykoupili na podzim více než na jaře?','Nabídka: A) $1\\,500\\ \\mathrm{kg}$; B) $1\\,800\\ \\mathrm{kg}$; C) $2\\,000\\ \\mathrm{kg}$; D) $2\\,100\\ \\mathrm{kg}$; E) $2\\,250\\ \\mathrm{kg}$; F) jiný počet kg.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: zbytek $1\\,200\\ \\mathrm{kg}$ je $40\\ \\%$ celku, celkem $1\\,200:0{,}4=3\\,000\\ \\mathrm{kg}$; odvezeno $60\\ \\%$, tj. $0{,}6\\cdot3\\,000=1\\,800\\ \\mathrm{kg}$ — \\textbf{B}.','15.2: na jedné paletě hmotnost $M$; prodáno $\\frac{2}{5}M+\\frac{1}{10}M=\\frac{1}{2}M=750\\Rightarrow M=1\\,500\\ \\mathrm{kg}$; obě palety $3\\,000\\ \\mathrm{kg}$; neprodané $3\\,000-750=2\\,250\\ \\mathrm{kg}$ — \\textbf{E}.','15.3: léto $1\\,500=1{,}5\\cdot$ jaro $\\Rightarrow$ jaro $1\\,000\\ \\mathrm{kg}$; léto $=0{,}5\\cdot$ podzim $\\Rightarrow$ podzim $3\\,000\\ \\mathrm{kg}$; rozdíl $3\\,000-1\\,000=2\\,000\\ \\mathrm{kg}$ — \\textbf{C}.'},
  '15.1: B; 15.2: E; 15.3: C',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 16',
  new List<String>{'Výsledný obrazec vytvoříme tímto postupem: 1. Na vodorovné přímce sestrojíme několik stejně vzdálených bodů (černých puntíků). 2. Prvním černým puntíkem vedeme dvě různoběžné šikmé přímky; druhým a každým dalším černým puntíkem vedeme rovnoběžky s oběma těmito přímkami. 3. Všechny nově vzniklé průsečíky označíme černými puntíky a těmi vedeme vodorovné přímky. 4. Na spodní vodorovné přímce označíme všechny nově vzniklé průsečíky bílými puntíky.','16.1 \\quad Výsledný obrazec obsahuje celkem $36$ černých puntíků. Určete počet všech vodorovných přímek v tomto obrazci.','16.2 \\quad Výsledný obrazec obsahuje celkem $49$ vodorovných přímek. Určete počet bílých puntíků na spodní vodorovné přímce tohoto obrazce.','16.3 \\quad Výsledný obrazec má na spodní vodorovné přímce celkem $64$ bílých puntíků. Určete počet všech černých puntíků v tomto obrazci.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Je-li na počáteční přímce $n$ černých puntíků, vytvoří obě soustavy rovnoběžek mřížku s $n^2$ průsečíky, takže černých puntíků je $n^2$. Průsečíky leží v $2n-1$ různých výškách, proto je vodorovných přímek $2n-1$. Spodní vodorovná přímka protíná šikmé přímky v $2n-1$ bodech, z nichž jeden (nejnižší vrchol) je již černý puntík, takže bílých puntíků je $2n-2$.','16.1: $n^2=36\\Rightarrow n=6$; vodorovných přímek $2\\cdot6-1=11$.','16.2: $2n-1=49\\Rightarrow n=25$; bílých puntíků $2\\cdot25-2=48$.','16.3: $2n-2=64\\Rightarrow n=33$; černých puntíků $33^2=1\\,089$.'},
  '16.1: $11$ vodorovných přímek; 16.2: $48$ bílých puntíků; 16.3: $1\\,089$ černých puntíků',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','algebra','uvazovani','slovni','bez-kalkulacky'},
  'M9PCD22C0T03', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
