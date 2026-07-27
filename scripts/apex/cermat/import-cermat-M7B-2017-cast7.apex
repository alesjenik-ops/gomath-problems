String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M7B 2017 – úloha 17',
  new List<String>{'Uvnitř šedého čtverce je umístěn bílý čtverec. Vrcholy bílého čtverce rozdělují každou stranu šedého čtverce na dva úseky dlouhé $1$ cm a $2$ cm.','Obdobným způsobem se umístí větší počet stejných bílých čtverců v řadě do šedého obdélníku. S přibývajícím počtem bílých čtverců se mění i délky stran šedého obdélníku. Rozměry v obrázcích jsou v cm.','17.1 Určete délky stran šedého obdélníku se dvěma bílými čtverci.','17.2 Určete délky stran šedého obdélníku s pěti bílými čtverci.','17.3 Delší strana šedého obdélníku měří $185$ cm. Určete délku kratší strany tohoto obdélníku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 230" font-family="sans-serif"><rect x="30" y="40" width="66" height="66" fill="#d0d0d0" stroke="#000" stroke-width="1.5"/><polygon points="52,40 96,62 74,106 30,84" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="41" y="34" font-size="12" text-anchor="middle">1</text><text x="24" y="66" font-size="12" text-anchor="end">2</text><text x="102" y="66" font-size="12">2</text><text x="85" y="122" font-size="12" text-anchor="middle">1</text><rect x="160" y="40" width="110" height="88" fill="#d0d0d0" stroke="#000" stroke-width="1.5"/><polygon points="182,40 226,62 204,106 160,84" fill="#fff" stroke="#000" stroke-width="1.5"/><polygon points="226,62 270,84 248,128 204,106" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="171" y="34" font-size="12" text-anchor="middle">1</text><text x="154" y="66" font-size="12" text-anchor="end">2</text><text x="276" y="66" font-size="12">2</text><text x="259" y="144" font-size="12" text-anchor="middle">1</text><text x="300" y="120" font-size="20" text-anchor="middle">…</text><rect x="320" y="40" width="242" height="154" fill="#d0d0d0" stroke="#000" stroke-width="1.5"/><polygon points="342,40 386,62 364,106 320,84" fill="#fff" stroke="#000" stroke-width="1.5"/><polygon points="386,62 430,84 408,128 364,106" fill="#fff" stroke="#000" stroke-width="1.5"/><polygon points="430,84 474,106 452,150 408,128" fill="#fff" stroke="#000" stroke-width="1.5"/><polygon points="474,106 518,128 496,172 452,150" fill="#fff" stroke="#000" stroke-width="1.5"/><polygon points="518,128 562,150 540,194 496,172" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="331" y="34" font-size="12" text-anchor="middle">1</text><text x="314" y="66" font-size="12" text-anchor="end">2</text><text x="568" y="66" font-size="12">2</text><text x="551" y="210" font-size="12" text-anchor="middle">1</text><text x="570" y="120" font-size="20" text-anchor="middle">…</text><text x="290" y="222" font-size="12" text-anchor="middle">Rozměry v obrázcích jsou v cm.</text></svg>',
  'sede-obdelniky.svg',
  'Tři obrázky: šedý čtverec 3 krát 3 cm s jedním bílým čtvercem, šedý obdélník se dvěma bílými čtverci a šedý obdélník s pěti bílými čtverci umístěnými v řadě.',
  'Šedý čtverec a šedé obdélníky s bílými čtverci',
  new List<String>{'U jednoho bílého čtverce je šedý útvar čtverec o straně $1+2=3$ cm.','Každý další bílý čtverec posune obrazec o $2$ cm ve vodorovném a o $1$ cm ve svislém směru.','Pro $n$ bílých čtverců je delší strana $2n+1$ cm a kratší strana $n+2$ cm.','17.1 $n=2$: kratší $2+2=4$ cm, delší $2\\cdot 2+1=5$ cm.','17.2 $n=5$: kratší $5+2=7$ cm, delší $2\\cdot 5+1=11$ cm.','17.3 $2n+1=185$, tedy $n=92$; kratší strana měří $92+2=94$ cm.'},
  '17.1: $4$ cm a $5$ cm; 17.2: $7$ cm a $11$ cm; 17.3: $94$ cm',
  4, 7, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
