String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD25C0T04';
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
  'CERMAT M7D 2025 - uloha 15',
  new List<String>{'Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).','15.1 Pan Zdenek bydli poslednich pet osmin sveho dosavadniho zivota v Plzni, kam se prestehoval, kdyz mu bylo $27$ let. Kolik let bydli pan Zdenek v Plzni?','15.2 Ze tri skol v obci je nejstarsi zakladni skola, ktera je v provozu jiz $84$ let. Funguje tedy o $75\\,\\%$ delsi dobu nez gymnazium. Nejmladsi skolou je lyceum. Pomer doby fungovani lycea a gymnazia je $2:3$. Kolik let funguje v obci lyceum?','15.3 Soucet veku dvojcat a jejich starsiho bratra je $99$ let. Kazdemu z dvojcat je o $40\\,\\%$ mene let nez jejich bratrovi. Kolik let je kazdemu z dvojcat?'},
  new List<String>{'A) $22$ let','B) $27$ let','C) $32$ let','D) $45$ let','E) $48$ let','F) vice nez $48$ let'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Pred Plzni prozil $27$ let, coz je $\\frac{3}{8}$ zivota, tedy cely zivot $72$ let. V Plzni bydli $\\frac{5}{8}\\cdot 72=45$ let - D.','15.2 Gymnazium: $84:1{,}75=48$ let. Lyceum $\\frac{2}{3}\\cdot 48=32$ let - C.','15.3 Bratr $b$, kazde dvojce $0{,}6b$. Soucet $b+2\\cdot 0{,}6b=2{,}2b=99$, tedy $b=45$ a dvojce $0{,}6\\cdot 45=27$ let - B.'},
  '15.1: D ($45$ let); 15.2: C ($32$ let); 15.3: B ($27$ let)',
  6, 9, '4',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2025 - uloha 16',
  new List<String>{'Hriste ma tvar obdelniku $KLMN$. Po jeho obvodu vede soutezni trasa se stanovisti $A$, $B$, $C$, $D$ (viz obrazek). Usecky $AC$ a $BD$ jsou rovnobezne se stranami hriste a vyznaceny sedy obrazec je ctverec. Usek $AKB$ soutezni trasy (ze stanoviste $A$ pres vrchol $K$ na stanoviste $B$) meri $45$ m. Usek $BLC$ meri $39$ m a posledni usek $CMD$ meri $30$ m.','16.1 Vypoctete v metrech rozdil mezi delkami usecek $BK$ a $BL$.','16.2 Vypoctete v metrech delku kratsi strany hriste.','16.3 Vypoctete v metrech obvod hriste.','16.4 Vypoctete v metrech vzdalenost stanoviste $D$ od vrcholu $N$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 260" font-family="sans-serif"><rect x="222" y="40" width="108" height="108" fill="#d0d0d0" stroke="none"/><rect x="60" y="40" width="270" height="180" fill="none" stroke="#000" stroke-width="1.8"/><line x1="222" y1="40" x2="222" y2="220" stroke="#000" stroke-width="1" stroke-dasharray="5 4"/><line x1="60" y1="148" x2="330" y2="148" stroke="#000" stroke-width="1" stroke-dasharray="5 4"/><circle cx="60" cy="148" r="3" fill="#000"/><circle cx="330" cy="148" r="3" fill="#000"/><text x="46" y="36" font-size="14" font-style="italic">K</text><text x="334" y="36" font-size="14" font-style="italic">N</text><text x="46" y="236" font-size="14" font-style="italic">L</text><text x="334" y="236" font-size="14" font-style="italic">M</text><text x="216" y="34" font-size="14" font-style="italic">A</text><text x="42" y="152" font-size="14" font-style="italic">B</text><text x="214" y="236" font-size="14" font-style="italic">C</text><text x="336" y="152" font-size="14" font-style="italic">D</text></svg>',
  'hriste-KLMN.svg',
  'Obdelnik KLMN se stanovisti A na horni strane, B na leve strane, C na dolni strane a D na prave strane; carkovane usecky AC a BD, sedy ctverec vpravo nahore.',
  'Hriste tvaru obdelniku KLMN se soutezni trasou',
  new List<String>{'Oznacme $|AK|=|LC|=a$ (usek $AC$ je rovnobezny se stranami), $|BK|=|MD|$ a $|BL|=|CM|$ podle stran ctverce a hriste. Ze zadani: $a+|BK|=45$, $|BL|+a=39$, $|CM|+|MD|=30$. Protoze sedy obrazec je ctverec, plati $|CM|=|MD|$ i $|AK|-|BL|$ je hrana ctverce. Reseni soustavy: $|BK|=18$ m, $|BL|=12$ m, $a=27$ m, kratsi strana $30$ m.','16.1 $|BK|-|BL|=18-12=6$ m.','16.2 Delsi strana $KN=45$ m, kratsi strana $KL=30$ m; kratsi strana meri $30$ m.','16.3 Obvod $2\\cdot(45+30)=150$ m.','16.4 $|DN|=|BK|=18$ m.'},
  '16.1: $6$ m; 16.2: $30$ m; 16.3: $150$ m; 16.4: $18$ m',
  4, 7, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
