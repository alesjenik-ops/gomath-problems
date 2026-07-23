String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD22C0T03';
Integer YEAR = 2022;

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
  'CERMAT M5C 2022 – úloha 9',
  new List<String>{'Hruškový král rozdělil podle zásluh všechny zlaté hrušky mezi tři rytíře. Druhý rytíř dostal o $24$ hrušek více než první rytíř a třetí rytíř dostal dvakrát více hrušek než první rytíř. Druhý a třetí rytíř dostali dohromady šestkrát více hrušek než první rytíř.','Kolik zlatých hrušek rozdělil král mezi tři rytíře?'},
  new List<String>{'A) $36$','B) $42$','C) $48$','D) $56$','E) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'První rytíř má $p$, druhý $p+24$, třetí $2p$. Druhý a třetí dohromady $6p$: $(p+24)+2p=6p$, odtud $24=3p$, tedy $p=8$. Rozděleno $8+32+16=56$ hrušek.'},
  'D) $56$',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2022 – úloha 10',
  new List<String>{'Obdélník je sestaven z bílého čtverce o obsahu $120$ cm² a dvou menších bílých čtverců. Uvnitř každého bílého čtverce je zakreslen tmavý čtverec, jehož vrcholy dělí všechny strany tohoto bílého čtverce na poloviny.','Jaký je celkový obsah všech tří tmavých čtverců v obdélníku?'},
  new List<String>{'A) $60$ cm²','B) $75$ cm²','C) $90$ cm²','D) $105$ cm²','E) $120$ cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 210 150" font-family="sans-serif"> <rect x="20" y="20" width="55" height="55" fill="#ffffff" stroke="#000"/> <rect x="20" y="75" width="55" height="55" fill="#ffffff" stroke="#000"/> <rect x="75" y="20" width="110" height="110" fill="#ffffff" stroke="#000"/> <polygon points="47.5,20 75,47.5 47.5,75 20,47.5" fill="#9a9a9a" stroke="#000"/> <polygon points="47.5,75 75,102.5 47.5,130 20,102.5" fill="#9a9a9a" stroke="#000"/> <polygon points="130,20 185,75 130,130 75,75" fill="#9a9a9a" stroke="#000"/> </svg>',
  'ctverce.svg',
  'Obdélník složený z velkého bílého čtverce a dvou menších; v každém je tmavý čtverec s vrcholy ve středech stran.',
  'Obdélník se třemi bílými a třemi tmavými čtverci',
  new List<String>{'Tmavý čtverec s vrcholy ve středech stran má poloviční obsah než bílý čtverec, v němž leží. Velký bílý čtverec má $120$ cm², každý menší $120 : 4 = 30$ cm² (jeho strana je poloviční). Tmavé čtverce: $\\frac{120}{2}+\\frac{30}{2}+\\frac{30}{2}=60+15+15=90$ cm².'},
  'C) $90$ cm²',
  2, 4, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
