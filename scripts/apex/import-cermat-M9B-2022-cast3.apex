String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 2. řádný termín (M9B)';
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
  'CERMAT 2022 M9B · úloha 10',
  new List<String>{'V rovině leží body $A$, $C$ a přímka $p$ (viz obrázek).','Body $A$, $C$ jsou vrcholy rovnoběžníku $ABCD$, jehož dvě strany jsou rovnoběžné s přímkou $p$. Jedna z úhlopříček rovnoběžníku $ABCD$ je k přímce $p$ kolmá.','10.1 Sestrojte střed $S$ rovnoběžníku $ABCD$ a označte ho písmenem.','10.2 Sestrojte vrcholy $B$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 328 214"><path d="M10 194L4 188M4 194L10 188M306 55L300 49M300 55L306 49M52 4L323 142" style="fill:none;stroke:#000000;stroke-width:2"/><text x="7" y="208" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="305" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="318" y="154" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text></svg>',
  'obr.svg',
  'V rovině leží přímka p (šikmá), bod A vlevo dole a bod C vpravo nahoře.',
  '',
  new List<String>{'10.1: úhlopříčky rovnoběžníku se navzájem půlí, proto střed $S$ je střed úsečky $AC$.','10.2: strany rovnoběžníku jsou rovnoběžné s $p$, tedy úhlopříčka $BD$ je k $p$ kolmá. Bodem $S$ vedeme kolmici k $p$; na ní leží vrcholy $B$ a $D$ souměrně podle $S$. Jejich polohu určíme tak, aby strany $AB$ a $CD$ byly rovnoběžné s $p$ (např. $AB\\parallel p$ určuje bod $B$ jako průsečík rovnoběžky s $p$ vedené bodem $A$ s kolmicí; $D$ je souměrný podle $S$).'},
  'Konstrukce středu $S$ (střed úsečky $AC$) a vrcholů $B$, $D$ rovnoběžníku $ABCD$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 11',
  new List<String>{'Ze tří stejných dřevěných krychlí byl slepen čtyřboký hranol, jehož síť má obsah $126\\ \\mathrm{cm}^2$ (viz obrázek sítě hranolu).','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Povrch hranolu je $14$krát větší než obsah stěny jedné krychle.','11.2 Síť krychle má obsah $42\\ \\mathrm{cm}^2$.','11.3 Nejkratší hrana hranolu měří $3\\ \\mathrm{cm}$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 104 113"><path d="M67 4L88 4L88 25L67 25ZM4 25L25 25L25 88L4 88ZM25 25L46 25L46 88L25 88ZM46 25L67 25L67 88L46 88ZM67 25L88 25L88 88L67 88ZM67 88L88 88L88 109L67 109Z" style="fill:none;stroke:#000000;stroke-width:2"/><text x="34" y="18" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Síť hranolu</text></svg>',
  'obr.svg',
  'Síť čtyřbokého hranolu složeného ze tří krychlí: řada čtyř obdélníků 1×3 a dva čtvercové podstavy.',
  '',
  new List<String>{'Krychle má hranu $a$. Hranol má rozměry $a\\times a\\times3a$; jeho povrch (obsah sítě) $=2a^2+4\\cdot3a^2=14a^2=126\\Rightarrow a^2=9\\Rightarrow a=3\\ \\mathrm{cm}$.','11.1: povrch hranolu $=126\\ \\mathrm{cm}^2$, obsah stěny krychle $=a^2=9\\ \\mathrm{cm}^2$; $126:9=14$ — pravda (A).','11.2: síť (povrch) jedné krychle $=6a^2=6\\cdot9=54\\ \\mathrm{cm}^2\\neq42$ — nepravda (N).','11.3: nejkratší hrana hranolu $=a=3\\ \\mathrm{cm}$ — pravda (A).'},
  '11.1: A; 11.2: N; 11.3: A',
  4, 6, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','uvazovani','bez-kalkulacky'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 12',
  new List<String>{'Reklamní plochu pro vylepování plakátů tvoří plášť rotačního válce. Podstava válce má poloměr $50\\ \\mathrm{cm}$. Plakát, který přesně pokryje celou reklamní plochu, má tvar čtverce.','Jaká je výška válce? Výsledek je zaokrouhlen na celé cm.'},
  new List<String>{'A) $157\\ \\mathrm{cm}$','B) $236\\ \\mathrm{cm}$','C) $314\\ \\mathrm{cm}$','D) $390\\ \\mathrm{cm}$','E) větší než $390\\ \\mathrm{cm}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Rozvinutý plášť je obdélník o šířce rovné obvodu podstavy $o=2\\pi r=2\\pi\\cdot50=100\\pi\\ \\mathrm{cm}$ a výšce $h$ (výška válce).','Plakát má tvar čtverce, tedy obdélník je čtverec: $h=100\\pi\\doteq314\\ \\mathrm{cm}$.'},
  'C) $314\\ \\mathrm{cm}$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','vyber','bez-kalkulacky'},
  'M9PBD22C0T02', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
