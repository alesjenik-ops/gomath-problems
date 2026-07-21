String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. náhradní termín (M9C)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2024 M9C · úloha 15',
  new List<String>{'Žáci 9. A a 9. B uvedli, jakou střední školu chtějí: gymnázium (GYM), SOŠ, nebo SOU. Na GYM chce $12$ žáků, na SOU $16\\ \\%$ žáků, na SOŠ všichni ostatní. Na uměleckou SOŠ chtějí $3$ žáci, na technickou $15$ žáků, zbytek SOŠ humanitní (viz grafy).','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','15.1 Na uměleckou střední školu chce jít $6\\ \\%$ všech žáků.','15.2 V 9. A a 9. B je celkem více než $50$ žáků.','15.3 Na gymnázia a na humanitní střední školy se chce hlásit stejný počet žáků.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 758 309"><path d="M4 120L189 120L189 305L4 305Z" style="fill:#ffffff"/><path d="M96 131C139 131 175 164 178 207L96 212L96 131M178 207C179 235 167 262 144 278L96 212L178 207M317 131C362 131 398 167 398 212C398 238 386 262 365 278L317 212L317 131" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M144 278C108 305 57 297 31 260C4 224 12 173 49 147C62 136 79 131 96 131L96 212L144 278Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M225 120L409 120L409 304L225 304Z" style="fill:#ffffff"/><path d="M365 278C351 288 334 293 317 293L317 212L365 278Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M317 293C272 293 236 257 236 212C236 167 272 131 317 131L317 212L317 293Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><text x="200" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">technický či umělecký. Výsledky průzkumu jsou zaznamenány v grafech. Na gymnázia</text><text x="203" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">chce jít studovat 12 žáků. Nejmenší zájem je o odborná učiliště, kam chce jít 16 % žáků.</text><text x="189" y="44" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Největší zájem je o střední odborné školy, na kterých chtějí studovat všichni, kteří</text><text x="208" y="60" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">nechtějí jít na gymnázia ani na odborná učiliště. Na uměleckou střední školu chtějí 3 žáci,</text><text x="200" y="75" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">15 žáků na technicky zaměřenou střední školu, ostatní, kteří chtějí na střední odborné</text><text x="74" y="91" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">školy, by si vybrali humanitní obor.</text><text x="98" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Zájem o gymnázia, SOŠ a SOU</text><text x="318" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">SOŠ podle zaměření</text><text x="61" y="216" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">60 %</text><text x="61" y="231" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">SOŠ</text><text x="135" y="178" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">12 žáků</text><text x="135" y="192" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">GYM</text><text x="145" y="232" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">16 %</text><text x="278" y="202" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">technické</text><text x="278" y="216" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">SOŠ</text><text x="278" y="231" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">15 žáků</text><text x="361" y="210" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">humanitní</text><text x="361" y="224" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">SOŠ</text></svg>',
  'obr.svg',
  'Dva kruhové diagramy: zájem o GYM, SOŠ, SOU a rozdělení SOŠ podle zaměření (technické, humanitní, umělecké).',
  '',
  new List<String>{'GYM $=100\\ \\%-60\\ \\%-16\\ \\%=24\\ \\%$; $12$ žáků $=24\\ \\%$, celkem $50$ žáků. SOŠ $60\\ \\%=30$ žáků.','15.1: umělecké $3$ z $50$ je $6\\ \\%$ — A.','15.2: celkem $50$ žáků, nikoli více — N.','15.3: humanitní SOŠ $30-15-3=12=$ GYM $12$ — A.'},
  '15.1: A; 15.2: N; 15.3: A',
  3, 5, '3',
  new List<String>{'zs2','r9','procenta','statistika','porozumeni','bez-kalkulacky','bezny-zivot'},
  'M9PCD24C0T03', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
