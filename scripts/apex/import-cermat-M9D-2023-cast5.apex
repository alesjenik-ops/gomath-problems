String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, druhý náhradní termín (M9D)';
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
  'CERMAT 2023 M9D · úloha 10',
  new List<String>{'V rovině leží přímky $b$, $c$ a na přímce $b$ leží bod A (viz obrázek).','Bod A je vrchol trojúhelníku ABC s pravým úhlem při vrcholu A. Na přímce $b$ leží vrchol B a na přímce $c$ leží vrchol C tohoto trojúhelníku. Velikost vnitřního úhlu trojúhelníku ABC při vrcholu C je $40^\\circ$.','Sestrojte vrcholy B, C trojúhelníku ABC, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 502 259"><path d="M4 224L5 224L5 225L4 225Z" style="fill:#000000"/><path d="M4 224L5 224L5 225L4 225Z" style="fill:#000000"/><path d="M5 224L467 224L467 225L5 225Z" style="fill:#000000"/><path d="M467 224L468 224L468 225L467 225Z" style="fill:#000000"/><path d="M467 224L468 224L468 225L467 225Z" style="fill:#000000"/><path d="M4 4L5 4L5 224L4 224Z" style="fill:#000000"/><path d="M467 4L468 4L468 224L467 224Z" style="fill:#000000"/><path d="M384 183L44 90M386 34L43 58M236 147L238 139" style="fill:none;stroke:#000000;stroke-width:2"/><text x="11" y="238" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">(</text><text x="22" y="238" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">CZVV</text><text x="35" y="238" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">)</text><text x="432" y="253" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">max. 2 body</text><text x="381" y="197" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">b</text><text x="383" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">c</text><text x="235" y="162" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text></svg>',
  'obr.svg',
  'V rovině leží přímky b, c a na přímce b leží bod A.',
  '',
  new List<String>{'Vrchol B leží na přímce $b$. Rameno AC je kolmé k AB (pravý úhel při A), tedy kolmé k přímce $b$; vrchol C je průsečík této kolmice (vedené bodem A) s přímkou $c$. Podmínku $|\\angle ACB|=40^\\circ$ využijeme k umístění B (např. přenesením úhlu $40^\\circ$ při C, nebo $50^\\circ$ při B).','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce, včetně nalezení všech řešení.'},
  'Konstrukce pravoúhlého trojúhelníku ABC (pravý úhel při A, B na $b$, C na $c$, $\\angle C=40^\\circ$).',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PDD23C0T04', 2023
);
c.add(
  'CERMAT 2023 M9D · úloha 11',
  new List<String>{'Každý rok pracují v parku jednak brigádníci, kteří tam pracovali v předchozím roce, jednak nově přijatí brigádníci. Na konci každého roku někteří z parku odcházejí. Graf udává počty brigádníků v letech 2018–2022 (tři údaje chybí). Např. v roce 2022 pracovalo $9$ brigádníků z předchozího roku a $6$ nově přijatých; z těchto $15$ jich $8$ na konci roku odešlo.','Z grafu (z předchozího roku / nově přijatí / na konci roku odešli): 2018: $14$ / $10$ / $8$; \\ 2019: chybí / $4$ / $7$; \\ 2020: $13$ / chybí / $3$; \\ 2021: $16$ / $5$ / chybí; \\ 2022: $9$ / $6$ / $8$.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 V roce 2019 pracovalo v parku $16$ brigádníků, kteří tam pracovali i v roce 2018.','11.2 V roce 2020 pracovalo v parku méně než $7$ nově přijatých brigádníků.','11.3 Na konci roku 2021 z parku odešlo více než $12$ brigádníků.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Počet, kdo přejde do dalšího roku $=$ celkový počet daného roku $-$ počet, kdo odešel.','2018: celkem $14+10=24$, odešlo $8$, přejde $16$. Tedy v roce 2019 je z předchozího roku $16$ (chybějící údaj).','2019: celkem $16+4=20$, odešlo $7$, přejde $13$ (souhlasí s údajem $13$ pro 2020).','2020: přejde do 2021 musí být $16$ (údaj 2021); $16=(13+\\text{nově})-3\\Rightarrow$ nově $=6$.','2021: celkem $16+5=21$; do 2022 přejde $9$ (údaj), tedy odešlo $21-9=12$.','11.1: z předchozího roku 2019 $=16$ — \\textbf{A}. 11.2: nově 2020 $=6<7$ — \\textbf{A}. 11.3: odešlo 2021 $=12$, ne více než $12$ — \\textbf{N}.'},
  '11.1: A; 11.2: A; 11.3: N',
  4, 6, '4',
  new List<String>{'zs2','r9','grafy','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PDD23C0T04', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
