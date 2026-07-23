String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD20C0T01';
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
  'CERMAT M7A 2020 – úloha 9',
  new List<String>{'V rovině leží přímka $p$ a polopřímka $AX$ (viz obrázek).','Bod $A$ je vrchol rovnostranného trojúhelníku $ABC$. Jeden ze zbývajících vrcholů $B$, $C$ leží na polopřímce $AX$ a druhý na přímce $p$. Polopřímka $AX$ tvoří jedno rameno vnitřního úhlu $\\alpha$ trojúhelníku $ABC$.','9.1 Sestrojte druhé rameno úhlu $\\alpha$ rovnostranného trojúhelníku $ABC$.','9.2 Sestrojte trojúhelník $ABC$ a jeho vrcholy označte písmeny. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <line x1="40" y1="150" x2="430" y2="238" stroke="#000" stroke-width="2"/> <text x="436" y="246" font-size="16" font-style="italic">p</text> <line x1="150" y1="292" x2="300" y2="66" stroke="#000" stroke-width="2"/> <polygon points="300,66 292,80 305,78" fill="#000"/> <text x="144" y="308" font-size="16" font-style="italic">A</text> <text x="306" y="70" font-size="16" font-style="italic">X</text> <line x1="234" y1="180" x2="244" y2="185" stroke="#000" stroke-width="2"/> </svg>',
  'primka-p-poloprimka-ax.svg',
  'Přímka p a polopřímka AX vycházející z bodu A; obě se protínají.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Vnitřní úhel rovnostranného trojúhelníku má $60^\\circ$. Druhé rameno úhlu $\\alpha$ sestrojíme otočením polopřímky $AX$ kolem bodu $A$ o $60^\\circ$ (na obě strany, tedy dvě polohy). Vrchol na přímce $p$ získáme jako průsečík příslušného ramene s přímkou $p$; druhý vrchol leží na polopřímce $AX$ ve stejné vzdálenosti od $A$ (kružnice se středem $A$). Úloha má dvě řešení: trojúhelníky $AB_1C_1$ a $AB_2C_2$.'},
  'Dvě řešení. Druhé rameno úhlu $\\alpha=60^\\circ$ vznikne otočením polopřímky $AX$ kolem $A$ o $60^\\circ$; vrcholy $B$, $C$ leží na polopřímce $AX$ a na přímce $p$ (trojúhelníky $AB_1C_1$ a $AB_2C_2$) — viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
