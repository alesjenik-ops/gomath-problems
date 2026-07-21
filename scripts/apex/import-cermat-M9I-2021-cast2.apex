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
  'CERMAT 2021 M9I · úloha 7',
  new List<String>{'Dvě bagety a $5$ housek váží o $480$ gramů více než $1$ bageta, ale o $40$ gramů méně než $3$ bagety. Všechny bagety jsou stejné, rovněž housky jsou stejné. Vypočtěte, kolik gramů váží','7.1 \\quad bageta,','7.2 \\quad houska.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť $b$ je hmotnost bagety, $h$ housky. $2b+5h=b+480$ a $2b+5h=3b-40$.','Z druhé rovnice $5h=b-40$; dosazením do $b+5h=480$: $b+(b-40)=480\\Rightarrow2b=520\\Rightarrow b=260\\ \\mathrm{g}$.','Pak $5h=260-40=220\\Rightarrow h=44\\ \\mathrm{g}$.'},
  '7.1: $260$ gramů; 7.2: $44$ gramů',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 8',
  new List<String>{'Obdélník ABCD má stranu BC délky $8\\ \\mathrm{cm}$. Na straně CD leží bod E. Obdélník je rozdělen úsečkami BE a BD na tři trojúhelníky. Obsahy trojúhelníků BCE a BED jsou stejné, a to $24\\ \\mathrm{cm}^2$ (viz obrázek). Vypočtěte','8.1 \\quad v cm$^2$ obsah lichoběžníku ABED,','8.2 \\quad v cm obvod lichoběžníku ABED.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 197 119"><path d="M8 14L79 14L150 99L8 99L8 14Z" style="fill:#d9d9d9"/><path d="M8 14L150 14L150 99L8 99ZM8 14L150 99M79 14L150 99" style="fill:none;stroke:#000000;stroke-width:2"/><text x="7" y="113" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="169" y="63" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text><text x="8" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="156" y="113" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="155" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="82" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text></svg>',
  'obr.svg',
  'Obdélník ABCD se stranou BC = 8 cm, bod E na straně CD; úsečky BD a BE dělí obdélník na trojúhelníky, vyznačen je lichoběžník ABED.',
  '',
  new List<String>{'Trojúhelník BCE má základnu CE a výšku $BC=8$: $\\frac{1}{2}\\cdot CE\\cdot8=24\\Rightarrow CE=6\\ \\mathrm{cm}$.','Trojúhelník BED má výšku $8$ (vzdálenost B od přímky CD): $\\frac{1}{2}\\cdot ED\\cdot8=24\\Rightarrow ED=6\\ \\mathrm{cm}$, takže $CD=12\\ \\mathrm{cm}$.','8.1: obsah obdélníku $=12\\cdot8=96\\ \\mathrm{cm}^2$; lichoběžník ABED $=96-24=72\\ \\mathrm{cm}^2$.','8.2: strany $AB=12$, $ED=6$, $DA=8$ a $BE=\\sqrt{6^2+8^2}=10\\ \\mathrm{cm}$; obvod $=12+6+8+10=36\\ \\mathrm{cm}$.'},
  '8.1: $72\\ \\mathrm{cm}^2$; 8.2: $36\\ \\mathrm{cm}$',
  4, 6, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','bez-kalkulacky'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 9',
  new List<String>{'V rovině leží přímka $p$ a přímka $a$ procházející bodem A (viz obrázek).','Bod A je vrchol čtverce ABCD. Na přímce $p$ leží jeden ze zbývajících vrcholů B, C, D tohoto čtverce a strana AB leží na přímce $a$. Celý čtverec leží v jedné polorovině s hraniční přímkou $p$.','Sestrojte vrcholy B, C, D čtverce ABCD, označte je písmeny a čtverec narýsujte. Najděte všechna $3$ řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 323 282"><path d="M4 8L318 162M197 278L51 4M138 159L130 163" style="fill:none;stroke:#000000;stroke-width:2"/><text x="313" y="174" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="63" y="13" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="132" y="179" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text></svg>',
  'obr.svg',
  'V rovině leží přímka p a přímka a procházející bodem A; na přímce a je vyznačen bod A.',
  '',
  new List<String>{'Postupně předpokládáme, že na přímce $p$ leží vrchol B, C, resp. D. Vrchol B (i C, D) musí ležet na přímce $a$ jen v případě strany AB; obecně využijeme, že úhly čtverce jsou pravé a strany shodné.','Pro každý ze tří případů sestrojíme kolmice a shodné úsečky (otočení o $90^\\circ$ kolem příslušného vrcholu) tak, aby vrchol ležel na $p$ a celý čtverec byl v jedné polorovině s hranicí $p$. Úloha má tři řešení (čtverce ABCD pro polohu B, C, D na $p$).','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce všech tří řešení.'},
  'Konstrukce tří čtverců ABCD (vrchol B, C, resp. D na přímce $p$, strana AB na přímce $a$); tři řešení.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PID21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
