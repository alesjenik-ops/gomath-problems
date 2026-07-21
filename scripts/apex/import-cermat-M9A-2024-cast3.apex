String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. řádný termín (M9A)';
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
  'CERMAT 2024 M9A · úloha 10',
  new List<String>{'V rovině leží přímka $AE$ a přímka $p$ procházející bodem $E$. Bod $A$ je vrchol obdélníku $ABCD$, vrchol $B$ leží na přímce $AE$ a vrchol $C$ na přímce $p$. Úhlopříčka $BD$ má stejnou délku jako úsečka $AE$ (viz obrázek).','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je a obdélník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 516 735"><path d="M4 4L5 4L5 443L4 443Z" style="fill:#231f20"/><path d="M4 443L5 443L5 444L4 444Z" style="fill:#231f20"/><path d="M4 443L5 443L5 444L4 444Z" style="fill:#231f20"/><path d="M5 443L456 443L456 444L5 444Z" style="fill:#231f20"/><path d="M456 4L458 4L458 443L456 443Z" style="fill:#231f20"/><path d="M456 443L458 443L458 444L456 444Z" style="fill:#231f20"/><path d="M456 443L458 443L458 444L456 444Z" style="fill:#231f20"/><path d="M45 348L415 216M157 111L366 320M102 320L107 330" style="fill:none;stroke:#231f20;stroke-width:2"/><path d="M489 455L512 455L512 731L489 731Z" style="fill:#ffffff"/></svg>',
  'obr.svg',
  'Přímka AE a přímka p procházející bodem E.',
  '',
  new List<String>{'Úhlopříčky obdélníku jsou stejně dlouhé a půlí se; $|BD|=|AC|=|AE|$.','Kružnice se středem $A$ a poloměrem $|AE|$ protne přímku $p$ ve vrcholu $C$; kolmice a rovnoběžky pak určí $B$ na přímce $AE$ a vrchol $D$.'},
  'Kružnice $(A,|AE|)$ protne přímku $p$ ve vrcholu $C$; $B$ leží na $AE$, $D$ doplníme jako obdélník (viz konstrukce).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 11',
  new List<String>{'Přímky $p$, $q$, $r$ se protínají a jejich průsečíky tvoří vrcholy trojúhelníku $ABC$. Jsou dány úhly $\\beta=23^\\circ$ (vnitřní úhel při vrcholu $B$) a $\\delta=107^\\circ$ (vnější úhel při vrcholu $A$ na přímce $q$).','Jaká je velikost rozdílu úhlů $\\gamma-\\alpha$? (Velikosti neměřte, ale vypočítejte.)'},
  new List<String>{'A) $10^\\circ$','B) $11^\\circ$','C) $12^\\circ$','D) $13^\\circ$','E) jiná velikost'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Vnitřní úhel při $A$: $\\alpha=180^\\circ-\\delta=73^\\circ$. Vnitřní úhel při $C$: $\\gamma=180^\\circ-\\alpha-\\beta=180^\\circ-73^\\circ-23^\\circ=84^\\circ$.','$\\gamma-\\alpha=84^\\circ-73^\\circ=11^\\circ$.'},
  'B) $11^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 12',
  new List<String>{'Obrazec (ve tvaru pětiúhelníku) je možné rozstříhat na $7$ shodných rovnoramenných trojúhelníků. Obvod jednoho takového trojúhelníku je $30\\ \\mathrm{cm}$.','Jaký je obvod celého obrazce?'},
  new List<String>{'A) $55\\ \\mathrm{cm}$','B) $60\\ \\mathrm{cm}$','C) $66\\ \\mathrm{cm}$','D) $72\\ \\mathrm{cm}$','E) $90\\ \\mathrm{cm}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Rovnoramenný trojúhelník má ramena délky $a$ a základnu $b$, obvod $2a+b=30\\ \\mathrm{cm}$; z rozměrů obrazce vychází $a=12\\ \\mathrm{cm}$, $b=6\\ \\mathrm{cm}$.','Obvod pětiúhelníku tvoří vnější strany trojúhelníků; jejich součet je $66\\ \\mathrm{cm}$.'},
  'C) $66\\ \\mathrm{cm}$',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 13',
  new List<String>{'Máme dva shodné čtverce A a B. Čtverec A je (svislými řezy) rozdělen na dva shodné obdélníky, čtverec B na pět shodných obdélníků. Obvod jednoho obdélníku ve čtverci A je o $6\\ \\mathrm{cm}$ větší než obvod jednoho obdélníku ve čtverci B.','Jaký je obvod jednoho ze čtverců A nebo B?'},
  new List<String>{'A) $40\\ \\mathrm{cm}$','B) $72\\ \\mathrm{cm}$','C) $80\\ \\mathrm{cm}$','D) $96\\ \\mathrm{cm}$','E) $128\\ \\mathrm{cm}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Strana čtverce $s$. Obdélník v A má obvod $2\\left(s+\\frac{s}{2}\\right)=3s$, v B $2\\left(s+\\frac{s}{5}\\right)=\\frac{12}{5}s$.','Rozdíl $3s-\\frac{12}{5}s=\\frac{3}{5}s=6\\Rightarrow s=10\\ \\mathrm{cm}$; obvod čtverce $4s=40\\ \\mathrm{cm}$.'},
  'A) $40\\ \\mathrm{cm}$',
  2, 4, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','rovnice','argumentace','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);
c.add(
  'CERMAT 2024 M9A · úloha 14',
  new List<String>{'Vynásobíme-li neznámé číslo dvěma a od výsledku odečteme $135$, získáme polovinu neznámého čísla. Jaká je hodnota neznámého čísla?'},
  new List<String>{'A) $270$','B) $170$','C) $135$','D) $90$','E) jiný výsledek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$2x-135=\\frac{x}{2}\\Rightarrow 2x-\\frac{x}{2}=135\\Rightarrow \\frac{3}{2}x=135\\Rightarrow x=90$.'},
  'D) $90$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','slovni','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PAD24C0T01', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
