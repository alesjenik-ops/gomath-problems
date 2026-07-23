String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND26C0T01';
Integer YEAR = 2026;

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
  'CERMAT M9 nanečisto 2026 – úloha 13',
  new List<String>{'V pravoúhlém trojúhelníku $ABC$ s pravým úhlem u vrcholu $C$ má odvěsna $AC$ délku 16 cm a přepona $AB$ délku 20 cm.','Jaký je obsah trojúhelníku $ABC$?'},
  new List<String>{'A) $96$ cm²','B) $104$ cm²','C) $112$ cm²','D) $120$ cm²','E) více než $120$ cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 220" font-family="sans-serif"> <polygon points="60,180 320,180 250,60" fill="none" stroke="#000" stroke-width="2"/> <path d="M238 72 L248 85 L259 77" fill="none" stroke="#000" stroke-width="1"/> <text x="46" y="196" font-size="15" font-style="italic">A</text> <text x="326" y="196" font-size="15" font-style="italic">B</text> <text x="250" y="52" font-size="15" font-style="italic">C</text> <text x="132" y="112" font-size="13">16 cm</text> <text x="178" y="198" font-size="13">20 cm</text> </svg>',
  'trojuhelnik-ABC.svg',
  'Pravoúhlý trojúhelník ABC s pravým úhlem u vrcholu C, odvěsnou AC 16 cm a přeponou AB 20 cm.',
  'Pravoúhlý trojúhelník ABC',
  new List<String>{'Druhá odvěsna $BC=\\sqrt{20^2-16^2}=\\sqrt{400-256}=\\sqrt{144}=12$ cm. Obsah $=\\frac{1}{2}\\cdot 16\\cdot 12=96$ cm².'},
  'A) $96$ cm²',
  2, 4, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 14',
  new List<String>{'Je dán kosočtverec $ABCD$ se středem $S$. Bod $X$ je střed strany $BC$ tohoto kosočtverce. Velikost úhlu $CSX$ je $20^\\circ$ (viz obrázek).','Jaká je velikost $\\varphi$ úhlu $ADB$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) méně než $40^\\circ$','B) $40^\\circ$','C) $50^\\circ$','D) $60^\\circ$','E) $70^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif"> <polygon points="120,210 300,210 360,90 180,90" fill="none" stroke="#000" stroke-width="2"/> <line x1="120" y1="210" x2="360" y2="90" stroke="#000"/> <line x1="300" y1="210" x2="180" y2="90" stroke="#000"/> <line x1="240" y1="150" x2="330" y2="150" stroke="#000"/> <circle cx="240" cy="150" r="2.5" fill="#000"/> <circle cx="330" cy="150" r="2.5" fill="#000"/> <text x="106" y="224" font-size="14" font-style="italic">A</text> <text x="300" y="228" font-size="14" font-style="italic">B</text> <text x="366" y="86" font-size="14" font-style="italic">C</text> <text x="162" y="86" font-size="14" font-style="italic">D</text> <text x="226" y="166" font-size="13" font-style="italic">S</text> <text x="337" y="150" font-size="13" font-style="italic">X</text> <text x="270" y="140" font-size="12">20 st.</text> <text x="196" y="114" font-size="13" font-style="italic">f</text> </svg>',
  'kosoctverec-ABCD.svg',
  'Kosočtverec ABCD s úhlopříčkami protínajícími se ve středu S, bodem X ve středu strany BC a vyznačeným úhlem 20 stupňů.',
  'Schematický nákres kosočtverce (obrázek je ilustrativní)',
  new List<String>{'Úhlopříčky kosočtverce jsou kolmé, trojúhelník $BSC$ je pravoúhlý s pravým úhlem u $S$. Bod $X$ je střed přepony $BC$, proto $|XS|=|XC|$ a trojúhelník $XSC$ je rovnoramenný: úhel $SCX$ = úhel $XSC=20^\\circ$. Tedy úhel $ACB=20^\\circ$ a úhel $BCD=2\\cdot 20^\\circ=40^\\circ$. V trojúhelníku $BCD$ je úhel $DBC=90^\\circ-20^\\circ=70^\\circ$ a úhel $BCD=40^\\circ$, takže úhel $BDC=70^\\circ$. Úhlopříčka $DB$ půlí úhel $ADC$, proto $\\varphi=$ úhel $ADB=$ úhel $BDC=70^\\circ$.'},
  'E) $70^\\circ$',
  2, 5, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
