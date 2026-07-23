String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD23C0T03';
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
  'CERMAT M7C 2023 - uloha 12',
  new List<String>{'Petiuhelnik $ABCDE$ se sklada z rovnoramenneho, rovnostranneho a pravouhleho trojuhelniku. Zakladnou rovnoramenneho trojuhelniku je strana $AB$. Strany $BC$ a $AE$ petiuhelniku jsou rovnobezne. Uhel pri vrcholu $A$ ma velikost $55^\\circ$.','Jaka je velikost uhlu $\\omega$ pri vrcholu $D$? Velikosti uhlu nemerte, ale vypoctete.'},
  new List<String>{'A) $65^\\circ$','B) $70^\\circ$','C) $75^\\circ$','D) $80^\\circ$','E) jina velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif"> <polygon points="60,300 360,300 470,180 410,110 160,150" fill="none" stroke="#000" stroke-width="2"/> <line x1="360" y1="300" x2="160" y2="150" stroke="#000" stroke-width="1.3"/> <line x1="360" y1="300" x2="410" y2="110" stroke="#000" stroke-width="1.3"/> <text x="52" y="318" font-size="15" font-style="italic">A</text> <text x="360" y="320" font-size="15" font-style="italic">B</text> <text x="478" y="184" font-size="15" font-style="italic">C</text> <text x="410" y="102" font-size="15" font-style="italic">D</text> <text x="140" y="150" font-size="15" font-style="italic">E</text> <text x="98" y="292" font-size="13">55 st.</text> <text x="392" y="140" font-size="15">omega</text> <rect x="452" y="176" width="9" height="9" fill="none" stroke="#000" stroke-width="1"/> </svg>',
  'petiuhelnik.svg',
  'Petiuhelnik ABCDE rozdeleny uhloprickami z vrcholu B na tri trojuhelniky; uhel 55 stupnu u A, uhel omega u D, pravy uhel u C.',
  'Vychozi obrazek k uloze 12',
  new List<String>{'Trojuhelnik $ABE$ je rovnoramenny se zakladnou $AB$, proto $|\\angle ABE|=|\\angle EAB|=55^\\circ$. Protoze $AE\\parallel BC$, je $|\\angle ABC|=180^\\circ-55^\\circ=125^\\circ$. Trojuhelnik $EBD$ je rovnostranny, tedy $|\\angle EBD|=60^\\circ$, a proto $|\\angle DBC|=125^\\circ-55^\\circ-60^\\circ=10^\\circ$. Trojuhelnik $BCD$ je pravouhly s pravym uhlem u vrcholu $C$, takze $\\omega=|\\angle BDC|=90^\\circ-10^\\circ=80^\\circ$.'},
  'D) $80^\\circ$',
  2, 6, '4',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
