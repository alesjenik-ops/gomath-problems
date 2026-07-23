String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD24C0T02';
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
  'CERMAT M5B 2024 – úloha 13',
  new List<String>{'Ve čtvercové síti je nakreslen obdélník $ABDF$, v němž jsou zakresleny trojúhelníky $BCJ$ a $EGH$. Vrcholy všech útvarů leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky 1 cm a obsah 1 cm² (viz obrázek).','Ke každé podúloze (13.1–13.3) přiřaďte správný výsledek (A–F).','13.1 Jaký je obsah trojúhelníku $BCJ$ v cm²?','13.2 Jaký je obsah trojúhelníku $EGH$ v cm²?','13.3 Jakým číslem musíme vynásobit obsah trojúhelníku $BCJ$, abychom dostali obsah obdélníku $ABDF$?'},
  new List<String>{'A) 6','B) 7','C) 8,5','D) 9','E) 9,5','F) 10'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 332" font-family="sans-serif"><line x1="30" y1="306" x2="30" y2="18" stroke="#ddd"/><line x1="62" y1="306" x2="62" y2="18" stroke="#ddd"/><line x1="94" y1="306" x2="94" y2="18" stroke="#ddd"/><line x1="126" y1="306" x2="126" y2="18" stroke="#ddd"/><line x1="158" y1="306" x2="158" y2="18" stroke="#ddd"/><line x1="190" y1="306" x2="190" y2="18" stroke="#ddd"/><line x1="222" y1="306" x2="222" y2="18" stroke="#ddd"/><line x1="254" y1="306" x2="254" y2="18" stroke="#ddd"/><line x1="286" y1="306" x2="286" y2="18" stroke="#ddd"/><line x1="318" y1="306" x2="318" y2="18" stroke="#ddd"/><line x1="350" y1="306" x2="350" y2="18" stroke="#ddd"/><line x1="30" y1="306" x2="350" y2="306" stroke="#ddd"/><line x1="30" y1="274" x2="350" y2="274" stroke="#ddd"/><line x1="30" y1="242" x2="350" y2="242" stroke="#ddd"/><line x1="30" y1="210" x2="350" y2="210" stroke="#ddd"/><line x1="30" y1="178" x2="350" y2="178" stroke="#ddd"/><line x1="30" y1="146" x2="350" y2="146" stroke="#ddd"/><line x1="30" y1="114" x2="350" y2="114" stroke="#ddd"/><line x1="30" y1="82" x2="350" y2="82" stroke="#ddd"/><line x1="30" y1="50" x2="350" y2="50" stroke="#ddd"/><line x1="30" y1="18" x2="350" y2="18" stroke="#ddd"/><polygon points="30,306 350,306 350,18 30,18" fill="none" stroke="#000" stroke-width="2"/><polygon points="350,306 350,114 254,210" fill="none" stroke="#000" stroke-width="1.6"/><polygon points="126,18 30,82 94,242" fill="none" stroke="#000" stroke-width="1.6"/><text x="24" y="320" font-size="13" font-style="italic">A</text><text x="354" y="320" font-size="13" font-style="italic">B</text><text x="354" y="15" font-size="13" font-style="italic">D</text><text x="19" y="15" font-size="13" font-style="italic">F</text><text x="356" y="118" font-size="13" font-style="italic">C</text><text x="259" y="207" font-size="13" font-style="italic">J</text><text x="124" y="15" font-size="13" font-style="italic">E</text><text x="18" y="86" font-size="13" font-style="italic">G</text><text x="91" y="257" font-size="13" font-style="italic">H</text></svg>',
  'sit-obdelnik.svg',
  'Čtvercová síť s obdélníkem ABDF a dvěma trojúhelníky BCJ a EGH; vrcholy v mřížových bodech.',
  'Schematický nákres (obsahy dle klíče)',
  new List<String>{'Obsahy počítáme v mřížce ($1$ čtvereček $=1$ cm²).','13.1 Trojúhelník $BCJ$ má obsah $9$ cm² → D.','13.2 Trojúhelník $EGH$ má obsah $9{,}5$ cm² → E.','13.3 Obdélník $ABDF$ má obsah $90$ cm²; $90:9=10$ → F.'},
  '13.1: D) 9; 13.2: E) 9,5; 13.3: F) 10',
  3, 5, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
