String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD26C0T02';
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
  'CERMAT M7B 2026 – úloha 6',
  new List<String>{'Záhon ve tvaru písmene L tvoří obrazec $ABCDEF$. Obrazec je rozdělen na 6 stejných čtverců, mezi nimiž jsou mezery tvaru obdélníku (viz obrázek). Všechny tyto obdélníky jsou stejné. Lomená čára $DEF$, která se skládá z úseček $DE$ a $EF$, má délku 550 cm. Lomená čára $ABC$, která se skládá z úseček $AB$ a $BC$, má délku 710 cm.','Určete v cm: 6.1 délku úsečky $DE$; 6.2 obvod jednoho čtverce; 6.3 délku úsečky $AB$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 290" font-family="sans-serif"><rect x="40" y="45" width="40" height="40" fill="#dcdcdc" stroke="#000"/><rect x="40" y="85" width="40" height="15" fill="#8f8f8f" stroke="#000"/><rect x="40" y="100" width="40" height="40" fill="#dcdcdc" stroke="#000"/><rect x="40" y="140" width="40" height="15" fill="#8f8f8f" stroke="#000"/><rect x="40" y="155" width="40" height="40" fill="#dcdcdc" stroke="#000"/><rect x="40" y="195" width="40" height="15" fill="#8f8f8f" stroke="#000"/><rect x="40" y="210" width="40" height="40" fill="#dcdcdc" stroke="#000"/><rect x="80" y="210" width="15" height="40" fill="#8f8f8f" stroke="#000"/><rect x="95" y="210" width="40" height="40" fill="#dcdcdc" stroke="#000"/><rect x="135" y="210" width="15" height="40" fill="#8f8f8f" stroke="#000"/><rect x="150" y="210" width="40" height="40" fill="#dcdcdc" stroke="#000"/><polygon points="40,45 40,250 190,250 190,210 80,210 80,45" fill="none" stroke="#000" stroke-width="2.5"/><text x="28" y="41" font-size="15" font-style="italic">A</text><text x="84" y="41" font-size="15" font-style="italic">F</text><text x="84" y="206" font-size="15" font-style="italic">E</text><text x="194" y="206" font-size="15" font-style="italic">D</text><text x="194" y="266" font-size="15" font-style="italic">C</text><text x="28" y="266" font-size="15" font-style="italic">B</text></svg>',
  'zahon-L.svg',
  'Obrazec ABCDEF ve tvaru písmene L složený ze šesti stejných čtverců oddělených stejnými obdélníkovými mezerami.',
  'Schematický nákres záhonu ve tvaru L',
  new List<String>{'Označme stranu čtverce $s$ a šířku mezery $g$. Pak $DE = 2s + 2g$, $EF = 3s + 3g$, tedy $DEF = 5s + 5g = 550$. Dále $AB = 4s + 3g$, $BC = 3s + 2g$, tedy $ABC = 7s + 5g = 710$.','Odečtením rovnic $5s + 5g = 550$ a $7s + 5g = 710$ dostaneme $2s = 160$, tj. $s = 80$ cm a $g = 30$ cm.','6.1 $DE = 2 \\cdot 80 + 2 \\cdot 30 = 220$ cm.','6.2 Obvod jednoho čtverce $= 4 \\cdot 80 = 320$ cm.','6.3 $AB = 4 \\cdot 80 + 3 \\cdot 30 = 410$ cm.'},
  '6.1: $220$ cm; 6.2: $320$ cm; 6.3: $410$ cm',
  4, 7, '4',
  new List<String>{'zs2','r7','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2026 – úloha 7',
  new List<String>{'Kvádr má podstavu o obsahu 54 cm². Obsahy tří stěn, které mají společný vrchol, jsou v poměru $6 : 15 : 10$. Nejmenší obsah z těchto tří stěn má podstava kvádru.','7.1 Vypočtěte v cm² povrch celého kvádru.','7.2 Obě podstavy kvádru jsou bílé. Na každé ze čtyř bočních stěn kvádru je šedý rovnoběžník, který má vrcholy ve středech hran kvádru (viz obrázek). Vypočtěte v cm² obsah všech čtyř šedých rovnoběžníků dohromady.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 250" font-family="sans-serif"> <polygon points="60,80 120,40 240,40 180,80" fill="#f2f2f2" stroke="#000"/> <polygon points="180,80 240,40 240,180 180,220" fill="#e2e2e2" stroke="#000"/> <rect x="60" y="80" width="120" height="140" fill="#fafafa" stroke="#000"/> <polygon points="120,80 180,150 120,220 60,150" fill="#9a9a9a" stroke="#000"/> <polygon points="210,60 240,110 210,200 180,150" fill="#9a9a9a" fill-opacity="0.6" stroke="#000"/> <text x="150" y="242" font-size="12" text-anchor="middle" fill="#555">schematický nákres kvádru</text> </svg>',
  'kvadr.svg',
  'Kvádr, na jehož čtyřech bočních stěnách jsou šedé rovnoběžníky s vrcholy ve středech hran.',
  'Schematický nákres kvádru se šedými rovnoběžníky',
  new List<String>{'7.1 Nejmenší stěna (podstava) odpovídá $6$ dílům poměru a má $54$ cm², takže $1$ díl $= 54 : 6 = 9$ cm². Povrch tvoří dvě sady těchto tří stěn, tj. $2 \\cdot (6 + 15 + 10) = 62$ dílů. Povrch $= 62 \\cdot 9 = 558$ cm².','7.2 Plášť (čtyři boční stěny) $= 558 - 2 \\cdot 54 = 450$ cm². Rovnoběžník spojující středy hran boční stěny má poloviční obsah než tato stěna, proto všechny čtyři dohromady mají $\\frac{1}{2} \\cdot 450 = 225$ cm².'},
  '7.1: $558$ cm²; 7.2: $225$ cm²',
  4, 7, '4',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
