String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M5A 2020 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží přímka $p$ a body $N$, $O$ (viz obrázek).','Body $N$, $O$ jsou vrcholy trojúhelníku $NOP$. Vrchol $P$ tohoto trojúhelníku leží na přímce $p$. Délka strany $NO$ je polovinou délky strany $OP$.','Sestrojte vrchol $P$ trojúhelníku $NOP$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 420" font-family="sans-serif"> <line x1="90" y1="360" x2="590" y2="250" stroke="#000" stroke-width="2"/> <text x="597" y="248" font-size="17" font-style="italic">p</text> <text x="392" y="234" font-size="17" text-anchor="middle">×</text> <text x="392" y="218" font-size="17" font-style="italic" text-anchor="middle">N</text> <text x="378" y="346" font-size="17" text-anchor="middle">×</text> <text x="378" y="366" font-size="17" font-style="italic" text-anchor="middle">O</text> </svg>',
  'primka-p-no.svg',
  'Přímka p směřující šikmo vzhůru doprava a body N a O.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Protože $|NO|$ je polovina $|OP|$, platí $|OP|=2\\cdot|NO|$. Vrchol $P$ tedy leží na přímce $p$ a zároveň na kružnici $k$ se středem $O$ a poloměrem $2\\cdot|NO|$. Průsečíky přímky $p$ a kružnice $k$ dávají dvě řešení $P_1$, $P_2$.'},
  'Konstrukce: $P$ je průsečík přímky $p$ a kružnice $k(O; 2|NO|)$; dvě řešení $P_1$, $P_2$ – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2020 – úloha 8',
  new List<String>{'Ve čtvercové síti jsou zakresleny dva tmavé obrazce $A$, $B$. Vrcholy obou obrazců leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky 1 cm a obsah 1 cm².','Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).','8.1 Obsah obrazce $A$ je 7 cm².','8.2 Obsah obrazce $B$ je o 1 cm² větší než obsah obrazce $A$.','8.3 Obvod obrazce $B$ je stejný jako obvod obrazce $A$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 310" font-family="sans-serif"><line x1="30" y1="20" x2="30" y2="260" stroke="#bbb" stroke-width="1"/><line x1="70" y1="20" x2="70" y2="260" stroke="#bbb" stroke-width="1"/><line x1="110" y1="20" x2="110" y2="260" stroke="#bbb" stroke-width="1"/><line x1="150" y1="20" x2="150" y2="260" stroke="#bbb" stroke-width="1"/><line x1="190" y1="20" x2="190" y2="260" stroke="#bbb" stroke-width="1"/><line x1="230" y1="20" x2="230" y2="260" stroke="#bbb" stroke-width="1"/><line x1="270" y1="20" x2="270" y2="260" stroke="#bbb" stroke-width="1"/><line x1="310" y1="20" x2="310" y2="260" stroke="#bbb" stroke-width="1"/><line x1="350" y1="20" x2="350" y2="260" stroke="#bbb" stroke-width="1"/><line x1="390" y1="20" x2="390" y2="260" stroke="#bbb" stroke-width="1"/><line x1="430" y1="20" x2="430" y2="260" stroke="#bbb" stroke-width="1"/><line x1="470" y1="20" x2="470" y2="260" stroke="#bbb" stroke-width="1"/><line x1="510" y1="20" x2="510" y2="260" stroke="#bbb" stroke-width="1"/><line x1="30" y1="20" x2="510" y2="20" stroke="#bbb" stroke-width="1"/><line x1="30" y1="60" x2="510" y2="60" stroke="#bbb" stroke-width="1"/><line x1="30" y1="100" x2="510" y2="100" stroke="#bbb" stroke-width="1"/><line x1="30" y1="140" x2="510" y2="140" stroke="#bbb" stroke-width="1"/><line x1="30" y1="180" x2="510" y2="180" stroke="#bbb" stroke-width="1"/><line x1="30" y1="220" x2="510" y2="220" stroke="#bbb" stroke-width="1"/><line x1="30" y1="260" x2="510" y2="260" stroke="#bbb" stroke-width="1"/><polygon points="70,60 190,60 190,180 110,220 150,140" fill="#c9c9c9" stroke="#000" stroke-width="2.5"/><text x="130" y="132" font-size="18" text-anchor="middle">A</text><polygon points="270,140 430,60 470,100 470,140 350,140 350,180 310,180" fill="#c9c9c9" stroke="#000" stroke-width="2.5"/><text x="390" y="116" font-size="18" text-anchor="middle">B</text><text x="270" y="282" font-size="13" text-anchor="middle">Strana čtverečku je 1 cm, obsah 1 cm².</text></svg>',
  'sit-obrazce-ab.svg',
  'Čtvercová síť 12 krát 6 se dvěma tmavými obrazci A (vlevo) a B (vpravo), vrcholy v mřížových bodech.',
  'Obrazce A a B ve čtvercové síti',
  new List<String>{'Obsah obrazce $A$ je $6$ cm² (nikoli $7$), tvrzení 8.1 je nepravdivé (Ne).','Obsah obrazce $B$ je $7$ cm², tj. o $1$ cm² více než $A$, tvrzení 8.2 je pravdivé (Ano).','Oba obrazce mají obvod $6+2\\sqrt{5}+2\\sqrt{2}$ cm (stejný), tvrzení 8.3 je pravdivé (Ano).'},
  '8.1: Ne; 8.2: Ano; 8.3: Ano',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
