String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD24C0T01';
Integer YEAR = 2024;

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
  'CERMAT M5A 2024 - uloha 11',
  new List<String>{'Mame sestiuhelnik $ABCDEF$, ktery lze useckami $AD$, $BE$ a $CF$ rozdelit na sest shodnych rovnoramennych trojuhelniku. Body $A$, $B$, $D$ a $E$ lezi ve vrcholech obdelniku. Obsah tmave casti sestiuhelniku je $112$ cm2 (viz obrazek).','Jaky je obsah bile casti sestiuhelniku?'},
  new List<String>{'A) $28$ cm2','B) $112$ cm2','C) $196$ cm2','D) $224$ cm2','E) jiny obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 260" font-family="sans-serif"> <polygon points="170,90 290,90 340,150 290,210 170,210 120,150" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="230,150 120,150 170,210" fill="#000"/> <polygon points="230,150 170,210 290,210" fill="#000"/> <line x1="170" y1="210" x2="290" y2="90" stroke="#000"/> <line x1="290" y1="210" x2="170" y2="90" stroke="#000"/> <line x1="340" y1="150" x2="120" y2="150" stroke="#000"/> <text x="158" y="228" font-size="14" font-style="italic">A</text> <text x="292" y="228" font-size="14" font-style="italic">B</text> <text x="346" y="154" font-size="14" font-style="italic">C</text> <text x="292" y="86" font-size="14" font-style="italic">D</text> <text x="156" y="86" font-size="14" font-style="italic">E</text> <text x="102" y="154" font-size="14" font-style="italic">F</text> <text x="150" y="128" font-size="13" font-style="italic">a</text> <text x="304" y="128" font-size="13" font-style="italic">a</text> <text x="248" y="186" font-size="13" font-style="italic" fill="#fff">a</text> </svg>',
  'sestiuhelnik.svg',
  'Sestiuhelnik ABCDEF rozdeleny na sest shodnych trojuhelniku, dva z nich jsou tmave.',
  'Sestiuhelnik rozdeleny na sest shodnych trojuhelniku',
  new List<String>{'Sestiuhelnik tvori $6$ shodnych trojuhelniku. Tmava cast jsou $2$ trojuhelniky o obsahu $112$ cm2, jeden trojuhelnik ma tedy $56$ cm2. Bilou cast tvori zbyle $4$ trojuhelniky: $4\\cdot 56=224$ cm2.'},
  'D) $224$ cm2',
  2, 3, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
