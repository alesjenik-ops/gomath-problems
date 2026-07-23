String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD25C0T04';
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
  'CERMAT M9D 2025 – úloha 14',
  new List<String>{'Jonáš a Beáta se zapojili do programu Ptačí hodinka. Každý v okolí svého krmítka sledoval výskyt ptáků v průběhu jedné vybrané hodiny. U každého ptačího druhu zaznamenali do grafu vždy nejvyšší počet jedinců spatřených najednou.','Jonáš spatřil pět druhů ptáků, zatímco Beáta pouze čtyři z nich. Oba dohromady zaznamenali pěnkav o $6$ méně než sýkor. Jonáš zaznamenal celkem o pětinu více ptačích jedinců než Beáta.','Kolik jedinců brhlíka lesního zaznamenala Beáta?'},
  new List<String>{'A) $2$ jedince','B) $3$ jedince','C) $4$ jedince','D) $5$ jedinců','E) více než $5$ jedinců'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 320" font-family="sans-serif"><line x1="55" y1="40" x2="55" y2="250" stroke="#000" stroke-width="1.4"/><line x1="55" y1="250" x2="510" y2="250" stroke="#000" stroke-width="1.4"/><text x="50" y="255" font-size="12" text-anchor="end">0</text><text x="20" y="150" font-size="12" text-anchor="middle" transform="rotate(-90 20 150)">Nejvyšší počet jedinců</text><rect x="71" y="106" width="22" height="144" fill="#5a5a5a" stroke="#000"/><rect x="97" y="154" width="22" height="96" fill="#d0d0d0" stroke="#000"/><text x="95" y="266" font-size="10" text-anchor="middle">kos</text><text x="95" y="278" font-size="10" text-anchor="middle">černý</text><rect x="156" y="154" width="22" height="96" fill="#5a5a5a" stroke="#000"/><rect x="182" y="150" width="22" height="100" fill="none" stroke="#000" stroke-dasharray="4 3"/><text x="193" y="208" font-size="16" text-anchor="middle" font-weight="bold">?</text><text x="180" y="266" font-size="10" text-anchor="middle">brhlík</text><text x="180" y="278" font-size="10" text-anchor="middle">lesní</text><rect x="241" y="58" width="22" height="192" fill="#5a5a5a" stroke="#000"/><rect x="267" y="58" width="22" height="192" fill="#d0d0d0" stroke="#000"/><text x="265" y="266" font-size="10" text-anchor="middle">sýkora</text><text x="265" y="278" font-size="10" text-anchor="middle">koňadra</text><rect x="326" y="202" width="22" height="48" fill="#5a5a5a" stroke="#000"/><text x="350" y="266" font-size="10" text-anchor="middle">červenka</text><text x="350" y="278" font-size="10" text-anchor="middle">obecná</text><rect x="411" y="154" width="22" height="96" fill="#5a5a5a" stroke="#000"/><rect x="437" y="106" width="22" height="144" fill="#d0d0d0" stroke="#000"/><text x="435" y="266" font-size="10" text-anchor="middle">pěnkava</text><text x="435" y="278" font-size="10" text-anchor="middle">obecná</text><rect x="450" y="46" width="14" height="14" fill="#5a5a5a" stroke="#000"/><text x="470" y="58" font-size="12">Jonáš</text><rect x="450" y="66" width="14" height="14" fill="#d0d0d0" stroke="#000"/><text x="470" y="78" font-size="12">Beáta</text></svg>',
  'graf-ptaci.svg',
  'Skupinový sloupcový graf počtu jedinců pěti ptačích druhů pro Jonáše a Beátu; počet brhlíků lesních u Beáty je označen otazníkem.',
  'Nejvyšší počet jedinců podle druhu (Jonáš, Beáta)',
  new List<String>{'Z grafu: kos černý Jonáš $6$, Beáta $4$; sýkora koňadra oba $8$; červenka obecná Jonáš $2$, Beáta $0$; pěnkava obecná Jonáš $4$, Beáta $6$; brhlík lesní Jonáš $4$, Beáta neznámý počet $x$. (Podmínka pěnkav o $6$ méně než sýkor: $4+6=(8+8)-6$ platí.)','Jonáš zaznamenal celkem $6+4+8+2+4=24$ jedinců, Beáta $4+x+8+0+6=18+x$. Z „o pětinu více" plyne $24=\\dfrac{6}{5}(18+x)$, odtud $18+x=20$, tj. $x=2$.'},
  'A) $2$ jedince',
  2, 7, '4',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
