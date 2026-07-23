String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD25C0T02';
Integer YEAR = 2025;

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
  'CERMAT M7B 2025 – úloha 10',
  new List<String>{'Velký rovnostranný trojúhelník, jehož obvod je 60 cm, byl rozdělen úsečkou na dva nové obrazce – lichoběžník a malý trojúhelník. Oba tyto nové obrazce mají stejný obvod.','Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).','10.1 Obvod malého trojúhelníku je 30 cm.','10.2 V lichoběžníku je délka kratší základny dvojnásobkem délky ramene.','10.3 V lichoběžníku jsou délky kratší a delší základny v poměru 3 : 4.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 220" font-family="sans-serif"> <polygon points="40,190 160,190 100,50" fill="none" stroke="#000" stroke-width="2"/> <polygon points="260,190 420,190 340,50" fill="none" stroke="#000" stroke-width="2"/> <line x1="300" y1="120" x2="380" y2="120" stroke="#000" stroke-width="1.6"/> </svg>',
  'trojuhelnik-lichobeznik.svg',
  'Rovnostranný trojúhelník a druhý stejný trojúhelník rozdělený vodorovnou úsečkou na malý trojúhelník nahoře a lichoběžník dole.',
  'Obrazce k úloze 10',
  new List<String>{'Strana velkého rovnostranného trojúhelníku je $60:3=20$ cm. Dělením vznikne nahoře malý rovnostranný trojúhelník o straně $s$ a dole lichoběžník se základnami 20 cm a $s$ a rameny $20-s$. Obvody: malý trojúhelník $3s$, lichoběžník $20+s+2\\left(20-s\\right)=60-s$. Z rovnosti $3s=60-s$ je $s=15$ cm.','10.1 Obvod malého trojúhelníku $3\\cdot 15=45$ cm, ne 30 cm → N.','10.2 Kratší základna 15 cm, rameno $20-15=5$ cm; $15\\neq 2\\cdot 5$ → N.','10.3 Základny 15 cm a 20 cm, poměr $15:20=3:4$ → A.'},
  '10.1: N; 10.2: N; 10.3: A',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2025 – úloha 11',
  new List<String>{'V rovině leží pravoúhlý trojúhelník $ABC$ s pravým úhlem u vrcholu $A$. Na odvěsně $AC$ leží střed $S$ kružnice $k$ o poloměru $r$. Kružnice $k$ prochází vrcholy $A$, $C$ trojúhelníku $ABC$ a protíná přeponu $BC$ v bodě $K$. Velikost úhlu při vrcholu $B$ je $56^\\circ$ (viz obrázek).','Jaká je velikost úhlu $\\omega$ (úhel $KSA$)? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $34^\\circ$','B) $48^\\circ$','C) $56^\\circ$','D) $68^\\circ$','E) více než $68^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 330" font-family="sans-serif"> <circle cx="120" cy="180" r="90" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="120,270 120,90 250,270" fill="none" stroke="#000" stroke-width="2"/> <line x1="120" y1="180" x2="205" y2="208" stroke="#000" stroke-width="1.3"/> <rect x="120" y="255" width="15" height="15" fill="none" stroke="#000" stroke-width="1"/> <text x="106" y="86" font-size="15" font-style="italic">C</text> <text x="102" y="288" font-size="15" font-style="italic">A</text> <text x="256" y="284" font-size="15" font-style="italic">B</text> <text x="126" y="176" font-size="15" font-style="italic">S</text> <text x="210" y="206" font-size="15" font-style="italic">K</text> <text x="126" y="140" font-size="14" font-style="italic">r</text> <text x="150" y="172" font-size="12" font-style="italic">r</text> <text x="143" y="203" font-size="13">ω</text> <text x="210" y="266" font-size="12">56°</text> </svg>',
  'trojuhelnik-kruznice.svg',
  'Pravoúhlý trojúhelník ABC s pravým úhlem u A, kružnice se středem S na odvěsně AC procházející body A a C a protínající přeponu BC v bodě K.',
  'Schematický nákres k úloze 11',
  new List<String>{'V pravoúhlém trojúhelníku je úhel při vrcholu $C$ roven $90^\\circ-56^\\circ=34^\\circ$. Body $A$, $C$ leží na kružnici se středem $S$ na úsečce $AC$, takže $S$ je střed $AC$ a $|SC|=|SK|=r$. Trojúhelník $SKC$ je rovnoramenný s úhlem $SCK=34^\\circ$, proto vnější úhel $\\omega=\\angle KSA=34^\\circ+34^\\circ=68^\\circ$.'},
  'D) $68^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
