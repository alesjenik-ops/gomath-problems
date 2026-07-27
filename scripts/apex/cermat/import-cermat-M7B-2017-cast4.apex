String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M7B 2017 – úloha 10',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $S$ (viz obrázek).','Bod $A$ je vrchol rovnoběžníku $ABCD$, bod $S$ je jeho střed. Jedna z úhlopříček rovnoběžníku $ABCD$ leží na přímce $p$. Úhlopříčka, která neleží na přímce $p$, je současně jednou z výšek rovnoběžníku $ABCD$.','Sestrojte chybějící vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$ a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 260" font-family="sans-serif"> <line x1="30" y1="120" x2="430" y2="120" stroke="#000" stroke-width="2.5"/> <text x="46" y="142" font-size="17" font-style="italic">p</text> <line x1="230" y1="110" x2="230" y2="130" stroke="#000" stroke-width="2"/> <text x="238" y="146" font-size="17" font-style="italic">S</text> <text x="180" y="205" font-size="16" text-anchor="middle">×</text> <text x="180" y="226" font-size="17" text-anchor="middle" font-style="italic">A</text> </svg>',
  'primka-p-bod-A.svg',
  'Vodorovná přímka p s vyznačeným bodem S a bod A ležící pod přímkou vlevo od bodu S.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Bod $A$ na přímce $p$ neleží, proto na $p$ leží úhlopříčka $BD$ a úhlopříčka $AC$ je výškou.','Vrchol $C$ získáme jako obraz bodu $A$ ve středové souměrnosti se středem $S$ (tj. $S$ je střed úsečky $AC$).','Protože $AC$ je výška, je $AC$ kolmá na strany $BC$ a $AD$. Bodem $C$ vedeme kolmici k $AC$; její průsečík s přímkou $p$ je vrchol $B$.','Vrchol $D$ je obraz bodu $B$ ve středové souměrnosti se středem $S$. Zbývá narýsovat rovnoběžník $ABCD$.'},
  '$C$ = obraz $A$ ve středové souměrnosti se středem $S$; $B$ = průsečík přímky $p$ s kolmicí k $AC$ vedenou bodem $C$; $D$ = obraz $B$ podle středu $S$ – viz obrázek v klíči.',
  3, 8, '4',
  new List<String>{'zs2','r7','konstrukce','modelovani','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2017 – úloha 11',
  new List<String>{'Z jednoho ze dvou shodných čtverců s délkou strany $6$ cm se odstřihl obdélník a přemístil se ke druhému čtverci. Rozměry obdélníku jsou $4$ cm a $2$ cm. Tak vznikly obrazce I a II (viz obrázek).','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Obvod obrazce I je menší než obvod obrazce II.','11.2 Obsah obrazce II je o $16$ cm² větší než obsah obrazce I.','11.3 Obsah obrazce II je $\\frac{11}{7}$ obsahu obrazce I.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 230" font-family="sans-serif"> <text x="105" y="34" font-size="15" text-anchor="middle" font-weight="bold">I</text> <text x="330" y="34" font-size="15" text-anchor="middle" font-weight="bold">II</text> <polygon points="30,45 180,45 180,70 130,70 130,170 180,170 180,195 30,195" fill="#d0d0d0" stroke="#000" stroke-width="2"/> <text x="20" y="124" font-size="13" text-anchor="end">6 cm</text> <text x="105" y="215" font-size="13" text-anchor="middle">6 cm</text> <text x="120" y="124" font-size="13" text-anchor="end">4 cm</text> <text x="156" y="186" font-size="13" text-anchor="middle">2 cm</text> <line x1="196" y1="120" x2="244" y2="120" stroke="#000" stroke-width="2"/> <polygon points="252,120 240,115 240,125" fill="#000"/> <polygon points="260,45 410,45 410,195 260,195 260,170 210,170 210,70 260,70" fill="#d0d0d0" stroke="#000" stroke-width="2"/> <text x="234" y="62" font-size="13" text-anchor="middle">2 cm</text> <text x="420" y="124" font-size="13">6 cm</text> <text x="335" y="215" font-size="13" text-anchor="middle">6 cm</text> </svg>',
  'obrazce-I-II.svg',
  'Obrazec I je čtverec 6 krát 6 cm s vyříznutým obdélníkem 2 krát 4 cm u pravé strany, obrazec II je čtverec 6 krát 6 cm s připojeným obdélníkem 2 krát 4 cm u levé strany.',
  'Obrazec I a obrazec II',
  new List<String>{'Obsah čtverce je $36$ cm², obsah odstřiženého obdélníku $4\\cdot 2=8$ cm².','Obrazec I má obsah $36-8=28$ cm², obrazec II má obsah $36+8=44$ cm².','11.1 Obvod I: $24-4+(2+4+2)=28$ cm; obvod II: $24-4+(2+4+2)=28$ cm. Obvody jsou stejné, tvrzení tedy neplatí → N.','11.2 $44-28=16$ cm² → A.','11.3 $\\frac{44}{28}=\\frac{11}{7}$ → A.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
