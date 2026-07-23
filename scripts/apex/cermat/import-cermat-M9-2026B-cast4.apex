String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD26C0T02';
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
  'CERMAT M9B 2026 – úloha 11',
  new List<String>{'Na parkovišti mohou auta stát jeden den nebo zůstat zaparkovaná nepřetržitě více dnů. Na noc se parkoviště pro vjezd a výjezd uzavírá. V grafu jsou znázorněny počty aut na parkovišti v průběhu pěti dnů, čtyři údaje však chybí. Např. v pátek bylo na parkovišti již před otevřením $9$ aut, která tam zůstala z předchozích dnů, během dne přibylo $12$ nově zaparkovaných aut a z těchto $21$ aut $3$ auta odjela.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 V pondělí bylo na parkovišti již před otevřením právě $10$ aut.','11.2 Ve středu na parkovišti nově zaparkovalo $9$ aut.','11.3 Ve čtvrtek ukončilo parkování méně než $12$ aut.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 400" font-family="sans-serif"><line x1="56" y1="30" x2="56" y2="352" stroke="#000"/><line x1="56" y1="210" x2="520" y2="210" stroke="#000"/><line x1="52" y1="210" x2="56" y2="210" stroke="#000"/><text x="49" y="214" font-size="10" text-anchor="end">0</text><line x1="52" y1="178" x2="56" y2="178" stroke="#000"/><text x="49" y="182" font-size="10" text-anchor="end">4</text><line x1="52" y1="146" x2="56" y2="146" stroke="#000"/><text x="49" y="150" font-size="10" text-anchor="end">8</text><line x1="52" y1="114" x2="56" y2="114" stroke="#000"/><text x="49" y="118" font-size="10" text-anchor="end">12</text><line x1="52" y1="82" x2="56" y2="82" stroke="#000"/><text x="49" y="86" font-size="10" text-anchor="end">16</text><line x1="52" y1="50" x2="56" y2="50" stroke="#000"/><text x="49" y="54" font-size="10" text-anchor="end">20</text><line x1="52" y1="242" x2="56" y2="242" stroke="#000"/><text x="49" y="246" font-size="10" text-anchor="end">4</text><line x1="52" y1="274" x2="56" y2="274" stroke="#000"/><text x="49" y="278" font-size="10" text-anchor="end">8</text><line x1="52" y1="306" x2="56" y2="306" stroke="#000"/><text x="49" y="310" font-size="10" text-anchor="end">12</text><line x1="52" y1="338" x2="56" y2="338" stroke="#000"/><text x="49" y="342" font-size="10" text-anchor="end">16</text><text x="16" y="210" font-size="11" text-anchor="middle" transform="rotate(-90 16 210)">Pocet aut</text><rect x="84" y="58" width="18" height="152" fill="none" stroke="#888" stroke-dasharray="4 3"/><text x="93" y="54" font-size="12" text-anchor="middle">?</text><rect x="106" y="98" width="18" height="112" fill="#d8d8d8" stroke="#000"/><rect x="95" y="210" width="18" height="24" fill="#111" stroke="#000"/><text x="102" y="370" font-size="11" text-anchor="middle">Po</text><rect x="176" y="82" width="18" height="128" fill="#7a7a7a" stroke="#000"/><rect x="198" y="178" width="18" height="32" fill="#d8d8d8" stroke="#000"/><rect x="187" y="210" width="18" height="56" fill="#111" stroke="#000"/><text x="194" y="370" font-size="11" text-anchor="middle">Ut</text><rect x="268" y="58" width="18" height="152" fill="none" stroke="#888" stroke-dasharray="4 3"/><text x="277" y="54" font-size="12" text-anchor="middle">?</text><rect x="290" y="58" width="18" height="152" fill="none" stroke="#888" stroke-dasharray="4 3"/><text x="299" y="54" font-size="12" text-anchor="middle">?</text><rect x="279" y="210" width="18" height="48" fill="#111" stroke="#000"/><text x="286" y="370" font-size="11" text-anchor="middle">St</text><rect x="360" y="82" width="18" height="128" fill="#7a7a7a" stroke="#000"/><rect x="382" y="170" width="18" height="40" fill="#d8d8d8" stroke="#000"/><rect x="371" y="210" width="18" height="120" fill="none" stroke="#888" stroke-dasharray="4 3"/><text x="380" y="342" font-size="12" text-anchor="middle">?</text><text x="378" y="370" font-size="11" text-anchor="middle">Ct</text><rect x="452" y="138" width="18" height="72" fill="#7a7a7a" stroke="#000"/><rect x="474" y="114" width="18" height="96" fill="#d8d8d8" stroke="#000"/><rect x="463" y="210" width="18" height="24" fill="#111" stroke="#000"/><text x="470" y="370" font-size="11" text-anchor="middle">Pa</text><rect x="60" y="388" width="11" height="11" fill="#7a7a7a"/><text x="75" y="397" font-size="9">zustala</text><rect x="150" y="388" width="11" height="11" fill="#d8d8d8" stroke="#000"/><text x="165" y="397" font-size="9">nove</text><rect x="220" y="388" width="11" height="11" fill="#111"/><text x="235" y="397" font-size="9">odjela</text></svg>',
  'graf-parkoviste.svg',
  'Skládaný sloupcový graf počtu aut na parkovišti pondělí až pátek; tři sloupce na den (zůstala z předchozích dnů, nově zaparkovaná, odjela), čtyři hodnoty chybí.',
  'Počty aut na parkovišti během pěti dnů (čtyři údaje chybí)',
  new List<String>{'Ráno přítomná auta $=$ ráno předchozího dne $+$ nově zaparkovaná $-$ odjelá.','11.1 Ráno v úterý bylo $16$ aut; v pondělí přibylo $14$ a odjela $3$, proto ráno v pondělí bylo $16-14+3=5$ aut. Tvrzení (10 aut) je nepravdivé → N.','11.2 Návazností dnů (ráno St $=$ ráno Út $+$ nově Út $-$ odjelá Út) vyjde, že ve středu nově zaparkovalo $9$ aut → A.','11.3 Ve čtvrtek platí $16+5-o=9$ (ráno v pátek), odtud $o=12$; odjelo $12$ aut, což není méně než $12$ → N.'},
  '11.1: N; 11.2: A; 11.3: N',
  4, 7, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
