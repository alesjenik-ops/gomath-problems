String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD25C0T02';
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
  'CERMAT M5B 2025 - uloha 7.1 (konstrukce)',
  new List<String>{'V rovine lezi bod $U$ a ruznobezne primky $p$, $q$ (viz obrazek).','Na primkach $p$, $q$ lezi dve strany pravouhleho trojuhelniku $ABC$. Treti strana $BC$ tohoto trojuhelniku prochazi bodem $U$.','Sestrojte vrcholy trojuhelniku $ABC$, oznacte je pismeny a trojuhelnik narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 260" font-family="sans-serif"> <line x1="60" y1="150" x2="430" y2="60" stroke="#000" stroke-width="2"/> <text x="437" y="58" font-size="16" font-style="italic">p</text> <line x1="70" y1="70" x2="410" y2="230" stroke="#000" stroke-width="2"/> <text x="415" y="240" font-size="16" font-style="italic">q</text> <text x="298" y="152" font-size="15">x</text> <text x="312" y="152" font-size="15" font-style="italic">U</text> </svg>',
  'primky-pq-U.svg',
  'Bod U a dve ruznobezne primky p a q.',
  'Vychozi obrazek k uloze 7.1',
  new List<String>{'Vrchol $A$ je prusecik primek $p$ a $q$; jedna odvesna lezi na $p$, druha na $q$. Pravy uhel je u vrcholu $B$ (resp. $C$), a proto strana $BC$ je kolma k jedne z primek. Bodem $U$ vedeme kolmici k primce $q$ - protne $q$ v bode $B$ a primku $p$ v bode $C$ (pravy uhel u $B$). Druhe reseni dostaneme kolmici z bodu $U$ k primce $p$. Existuji dve reseni.'},
  'Dve reseni. $A$ je prusecik primek $p$ a $q$; strana $BC$ prochazi bodem $U$ a je kolma k jedne z primek (pravy uhel v $B$, resp. $C$) - viz obrazek v klici.',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2025 - uloha 7.2 (konstrukce)',
  new List<String>{'V rovine lezi bod $K$ a ruznobezne primky $r$, $s$ (viz obrazek).','Bod $K$ je vrchol obdelniku $KLMN$. Strana $KL$ tohoto obdelniku je rovnobezna s primkou $r$. Na primce $s$ lezi stred $S$ strany $KN$ a vrchol $M$ obdelniku $KLMN$.','Sestrojte bod $S$ a vrcholy $L$, $M$, $N$ obdelniku $KLMN$, oznacte je pismeny a obdelnik narysujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="70" y1="150" x2="430" y2="150" stroke="#000" stroke-width="2"/> <text x="437" y="155" font-size="16" font-style="italic">s</text> <line x1="130" y1="120" x2="380" y2="270" stroke="#000" stroke-width="2"/> <text x="386" y="278" font-size="16" font-style="italic">r</text> <text x="150" y="212" font-size="15">x</text> <text x="150" y="230" font-size="15" font-style="italic">K</text> </svg>',
  'primky-rs-K.svg',
  'Bod K a dve ruznobezne primky r a s.',
  'Vychozi obrazek k uloze 7.2',
  new List<String>{'Strana $KN$ je kolma ke strane $KL$, a protoze $KL$ je rovnobezna s $r$, je $KN$ kolma k $r$. Bodem $K$ vedeme kolmici k primce $r$; jeji prusecik s primkou $s$ je stred $S$ strany $KN$. Vrchol $N$ je soumerny s bodem $K$ podle stredu $S$ (na teze kolmici, $|SN|=|SK|$). Vrchol $M$ je prusecik primky $s$ s rovnobezkou s primkou $r$ vedenou bodem $N$. Vrchol $L$ dostaneme jako prusecik rovnobezky s $r$ vedene bodem $K$ a kolmice k $r$ vedene bodem $M$. Obdelnik $KLMN$ narysujeme.'},
  'Kolmice z $K$ k $r$ protne $s$ ve stredu $S$ strany $KN$; $N$ je obraz $K$ ve stredu $S$; $M$ je prusecik $s$ s rovnobezkou s $r$ bodem $N$, $L$ doplnime na obdelnik - viz obrazek v klici.',
  3, 6, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
