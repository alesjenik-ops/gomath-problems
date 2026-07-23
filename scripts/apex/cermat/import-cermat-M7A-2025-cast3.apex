String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD25C0T01';
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
  'CERMAT M7A 2025 - uloha 8 (konstrukce)',
  new List<String>{'V rovine lezi body $B$, $C$, $O$ (viz obrazek).','Body $B$, $C$ jsou vrcholy trojuhelniku $ABC$. Poloprimka $BC$ tvori rameno vnitrniho uhlu trojuhelniku $ABC$ pri vrcholu $B$ a primka $BO$ je osa tohoto uhlu. Vrcholy $A$ i $B$ maji stejnou vzdalenost od bodu $O$.','8.1 Sestrojte obe ramena vnitrniho uhlu trojuhelniku $ABC$ pri vrcholu $B$.','8.2 Sestrojte vrchol $A$ trojuhelniku $ABC$, oznacte ho pismenem a trojuhelnik narysujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 280" font-family="sans-serif"> <rect x="5" y="5" width="470" height="270" fill="none" stroke="#ccc"/> <text x="150" y="72" font-size="15">&#215;</text><text x="162" y="72" font-size="15" font-style="italic">B</text> <text x="120" y="215" font-size="15">&#215;</text><text x="112" y="232" font-size="15" font-style="italic">C</text> <text x="235" y="222" font-size="15">&#215;</text><text x="245" y="238" font-size="15" font-style="italic">O</text> </svg>',
  'body-BCO.svg',
  'Body B, C, O v rovine.',
  'Vychozi obrazek k uloze 8',
  new List<String>{'8.1 Jedno rameno uhlu je poloprimka $BC$. Druhe rameno je obrazem poloprimky $BC$ v osove soumernosti podle primky $BO$ (osy uhlu).','8.2 Vrchol $A$ lezi na druhem rameni a zaroven (protoze $|OA|=|OB|$) na kruznici se stredem $O$ a polomerem $|OB|$. Prusecik urci bod $A$; trojuhelnik $ABC$ narysujeme.'},
  'Konstrukce: druhe rameno uhlu pri $B$ je obraz poloprimky $BC$ v osove soumernosti podle primky $BO$; vrchol $A$ je prusecik tohoto ramene s kruznici se stredem $O$ a polomerem $|OB|$ (viz nacrt v klici).',
  3, 7, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2025 - uloha 9 (konstrukce)',
  new List<String>{'V rovine lezi body $E$, $F$, $G$ (viz obrazek).','Body $E$, $F$, $G$ jsou vrcholy rovnoramenneho lichobezniku $EFGH$. Sestrojte vrchol $H$ lichobezniku $EFGH$, oznacte ho pismenem a lichobeznik narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 280" font-family="sans-serif"> <rect x="5" y="5" width="470" height="270" fill="none" stroke="#ccc"/> <text x="300" y="98" font-size="15">&#215;</text><text x="312" y="98" font-size="15" font-style="italic">G</text> <text x="300" y="188" font-size="15">&#215;</text><text x="310" y="204" font-size="15" font-style="italic">F</text> <text x="150" y="218" font-size="15">&#215;</text><text x="142" y="234" font-size="15" font-style="italic">E</text> </svg>',
  'body-EFG.svg',
  'Body E, F, G v rovine.',
  'Vychozi obrazek k uloze 9',
  new List<String>{'Rovnoramenny lichobeznik ma jednu dvojici protejsich stran rovnobeznou a obe ramena shodna. Vrchol $H$ doplnime tak, aby $EFGH$ byl rovnoramenny lichobeznik.','Uloha ma dve reseni $H_1$, $H_2$ (viz nacrt v klici).'},
  'Dve reseni ($H_1$, $H_2$): vrchol $H$ doplnime tak, aby $EFGH$ byl rovnoramenny lichobeznik (rovnobezne zakladny, shodna ramena) - viz nacrt v klici.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
