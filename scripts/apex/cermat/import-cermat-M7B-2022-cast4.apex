String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD22C0T02';
Integer YEAR = 2022;

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
  'CERMAT M7B 2022 – úloha 8',
  new List<String>{'V rovině leží body $P$, $S$ a přímka $m$ (viz obrázek).','Bod $S$ je střed kružnice $k$, která má poloměr $5$ cm. Bod $P$ je vrchol rovnostranného trojúhelníku $PQR$. Další vrchol tohoto trojúhelníku leží v průsečíku přímky $m$ s kružnicí $k$ a poslední vrchol trojúhelníku $PQR$ leží uvnitř kružnice $k$.','Sestrojte vrcholy $Q$, $R$ trojúhelníku $PQR$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif" font-size="15"> <rect x="4" y="4" width="412" height="292" fill="none" stroke="#ccc"/> <line x1="60" y1="70" x2="360" y2="250" stroke="#000" stroke-width="2"/> <text x="48" y="76" font-style="italic">m</text> <text x="180" y="205" text-anchor="middle">×</text> <text x="180" y="222" text-anchor="middle" font-style="italic">P</text> <text x="250" y="150" text-anchor="middle">×</text> <text x="250" y="167" text-anchor="middle" font-style="italic">S</text> </svg>',
  'primka-m-body.svg',
  'Přímka m vedená z levého horního rohu dolů doprava, bod P pod přímkou vlevo a bod S nad přímkou uprostřed.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Bod $S$ je střed kružnice $k$ o poloměru $5$ cm — kružnici $k$ narýsujeme. Vrchol $Q$ leží v průsečíku přímky $m$ s kružnicí $k$; ta má dva průsečíky $Q_1$, $Q_2$. Trojúhelník $PQR$ je rovnostranný, proto třetí vrchol $R$ (uvnitř kružnice) sestrojíme jako průsečík kružnic se středy $P$ a $Q$ a poloměrem $|PQ|$. Úloha má dvě řešení.'},
  'Dvě řešení: kružnice $k$ se středem $S$ a poloměrem $5$ cm, vrchol $Q$ v průsečíku přímky $m$ a kružnice $k$ ($Q_1$, $Q_2$), rovnostranné trojúhelníky $PQ_1R_1$ a $PQ_2R_2$ (viz obrázek v klíči).',
  3, 8, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 9',
  new List<String>{'V rovině leží body $A$, $O$ a přímka $p$ procházející bodem $O$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Na přímce $p$ leží vrchol $C$ tohoto obdélníku. Bod $O$ je střed některé strany obdélníku $ABCD$.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif" font-size="15"> <rect x="4" y="4" width="412" height="252" fill="none" stroke="#ccc"/> <line x1="60" y1="200" x2="370" y2="70" stroke="#000" stroke-width="2"/> <text x="48" y="212" font-style="italic">p</text> <line x1="208" y1="128" x2="222" y2="142" stroke="#000"/> <text x="224" y="150" font-style="italic">O</text> <text x="330" y="150" text-anchor="middle">×</text> <text x="330" y="167" text-anchor="middle" font-style="italic">A</text> </svg>',
  'primka-p-body.svg',
  'Přímka p vedená z levého dolního rohu nahoru doprava, na ní bod O, a bod A vpravo pod přímkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Bod $O$ (na přímce $p$) je střed některé strany obdélníku a vrchol $C$ leží na přímce $p$. Z podmínek pravých úhlů obdélníku a středu strany sestrojíme vrcholy $B$, $C$, $D$. Úloha má dvě řešení (obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$).'},
  'Dvě řešení: obdélníky s vrcholem $A$, vrcholem $C$ na přímce $p$ a bodem $O$ jako středem některé strany (viz obrázek v klíči).',
  3, 8, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
