String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD23C0T02';
Integer YEAR = 2023;

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
  'CERMAT M7B 2023 - uloha 14',
  new List<String>{'Sara, Lukas, Dan a Adela hrali hru, ve ktere ziskavali body. Sara ziskala stejny pocet bodu jako Lukas. Dan ziskal 60 bodu, coz je o polovinu bodu vice, nez ziskali Sara a Lukas dohromady, ale o ctvrtinu bodu mene, nez ziskala Adela.','Ktery z grafu A-E v testovem sesitu zobrazuje odpovidajici pocty bodu ziskanych ve hre?'},
  new List<String>{'A) Sara 30, Lukas 30, Dan 60, Adela asi 72','B) Sara 10, Lukas 10, Dan 60, Adela asi 45','C) Sara 10, Lukas 10, Dan 60, Adela asi 72','D) Sara 20, Lukas 20, Dan 60, Adela asi 80','E) Sara 20, Lukas 20, Dan 60, Adela asi 45'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Z podminky $60=\\frac{3}{2}(S+L)$ plyne $S+L=40$, tedy $S=L=20$. Z podminky $60=\\frac{3}{4}A$ (Dan ma o ctvrtinu mene nez Adela) plyne $A=80$. Hodnotam Sara 20, Lukas 20, Dan 60, Adela 80 odpovida graf D.'},
  'D) Sara 20, Lukas 20, Dan 60, Adela asi 80',
  2, 4, '3',
  new List<String>{'zs2','r7','statistika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2023 - uloha 15',
  new List<String>{'Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).','15.1 Castka 200 tisic korun vyclenena na odmeny byla rozdelena mezi dve oddeleni. Prvni oddeleni dostalo z teto castky 130 tisic korun. Kolik procent z vyclenene castky dostalo druhe oddeleni?','15.2 Maminka umyla 40 % oken v dome. Ze zbyvajicich 12 oken v dome jich 9 umyl tatinek. Kolik procent oken v dome umyl tatinek?','15.3 Jonas si z kapesneho koupil pouze knihu a mic. Za knihu utratil ctvrtinu kapesneho a za mic pak utratil 20 % zbytku kapesneho. Vse, co z kapesneho neutratil, ulozil do kasicky. Kolik procent kapesneho ulozil Jonas do kasicky?'},
  new List<String>{'A) mene nez 35 %','B) 35 %','C) 45 %','D) 55 %','E) 60 %','F) vice nez 60 %'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Druhe oddeleni dostalo $200-130=70$ tisic korun, tj. $\\frac{70}{200}=35\\,\\%$ vyclenene castky -> B.','15.2 Zbyvajicich 12 oken je $60\\,\\%$ vsech oken, celkem je tedy $20$ oken; tatinek umyl $\\frac{9}{20}=45\\,\\%$ -> C.','15.3 Kniha $25\\,\\%$, zbytek $75\\,\\%$; mic $20\\,\\%$ ze $75\\,\\%$, tj. $15\\,\\%$. Do kasicky ulozil $75\\,\\%-15\\,\\%=60\\,\\%$ -> E.'},
  '15.1: B (35 %); 15.2: C (45 %); 15.3: E (60 %)',
  6, 9, '4',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
