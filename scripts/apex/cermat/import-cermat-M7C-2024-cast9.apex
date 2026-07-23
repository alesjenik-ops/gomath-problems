String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD24C0T03';
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
  'CERMAT M7C 2024 – úloha 14',
  new List<String>{'Graf znázorňuje výšku hladiny Vltavy v průběhu tří týdnů z července; nula je normální stav $120$ cm (viz obrázek). Část Vltavy je pro vodáky splavná až od $135$ cm a za ten den na ni může nejvýše $50$ kajaků po $3$ lidech a $10$ raftů po $6$ lidech.','Rozhodněte o každém z tvrzení 14.1–14.3, zda je pravdivé (A), či nikoli (N).','14.1 Vltava byla splavná méně než $23\\,\\%$ sledovaných dnů.','14.2 Na Vltavu se za uvedené období mohlo dostat nejvýše $1\\,260$ lidí.','14.3 $13.\\,7.$ mohla nastat situace, že lidé na raftech tvořili alespoň $30\\,\\%$ vodáků.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 300" font-family="sans-serif"><line x1="54" y1="206" x2="600" y2="206" stroke="#ddd"/><text x="48" y="210" font-size="10" text-anchor="end">-40</text><line x1="54" y1="192" x2="600" y2="192" stroke="#ddd"/><text x="48" y="196" font-size="10" text-anchor="end">-30</text><line x1="54" y1="178" x2="600" y2="178" stroke="#ddd"/><text x="48" y="182" font-size="10" text-anchor="end">-20</text><line x1="54" y1="164" x2="600" y2="164" stroke="#ddd"/><text x="48" y="168" font-size="10" text-anchor="end">-10</text><line x1="54" y1="150" x2="600" y2="150" stroke="#ddd"/><text x="48" y="154" font-size="10" text-anchor="end">0</text><line x1="54" y1="136" x2="600" y2="136" stroke="#ddd"/><text x="48" y="140" font-size="10" text-anchor="end">10</text><line x1="54" y1="122" x2="600" y2="122" stroke="#ddd"/><text x="48" y="126" font-size="10" text-anchor="end">20</text><line x1="54" y1="108" x2="600" y2="108" stroke="#ddd"/><text x="48" y="112" font-size="10" text-anchor="end">30</text><line x1="54" y1="94" x2="600" y2="94" stroke="#ddd"/><text x="48" y="98" font-size="10" text-anchor="end">40</text><line x1="54" y1="150" x2="600" y2="150" stroke="#000"/><text x="62" y="86" font-size="9">1</text><rect x="62" y="150" width="18" height="42" fill="#8a8a8a"/><text x="88" y="86" font-size="9">2</text><rect x="88" y="150" width="18" height="49" fill="#8a8a8a"/><text x="114" y="86" font-size="9">3</text><rect x="114" y="150" width="18" height="56" fill="#8a8a8a"/><text x="140" y="86" font-size="9">4</text><rect x="140" y="150" width="18" height="42" fill="#8a8a8a"/><text x="166" y="86" font-size="9">5</text><rect x="166" y="150" width="18" height="28" fill="#8a8a8a"/><text x="192" y="86" font-size="9">6</text><rect x="192" y="150" width="18" height="28" fill="#8a8a8a"/><text x="218" y="86" font-size="9">7</text><rect x="218" y="150" width="18" height="21" fill="#8a8a8a"/><text x="244" y="86" font-size="9">8</text><rect x="244" y="150" width="18" height="14" fill="#8a8a8a"/><text x="270" y="86" font-size="9">9</text><rect x="270" y="150" width="18" height="7" fill="#8a8a8a"/><text x="296" y="86" font-size="9">10</text><rect x="296" y="129" width="18" height="21" fill="#8a8a8a"/><text x="322" y="86" font-size="9">11</text><rect x="322" y="122" width="18" height="28" fill="#8a8a8a"/><text x="348" y="86" font-size="9">12</text><rect x="348" y="122" width="18" height="28" fill="#8a8a8a"/><text x="374" y="86" font-size="9">13</text><rect x="374" y="108" width="18" height="42" fill="#8a8a8a"/><text x="400" y="86" font-size="9">14</text><rect x="400" y="90" width="18" height="60" fill="none" stroke="#888" stroke-dasharray="3 3"/><text x="403" y="122" font-size="14">?</text><text x="426" y="86" font-size="9">15</text><rect x="426" y="129" width="18" height="21" fill="#8a8a8a"/><text x="452" y="86" font-size="9">16</text><rect x="452" y="136" width="18" height="14" fill="#8a8a8a"/><text x="478" y="86" font-size="9">17</text><rect x="478" y="143" width="18" height="7" fill="#8a8a8a"/><text x="504" y="86" font-size="9">18</text><rect x="504" y="150" width="18" height="7" fill="#8a8a8a"/><text x="530" y="86" font-size="9">19</text><rect x="530" y="150" width="18" height="14" fill="#8a8a8a"/><text x="556" y="86" font-size="9">20</text><rect x="556" y="150" width="18" height="21" fill="#8a8a8a"/><text x="582" y="86" font-size="9">21</text><rect x="582" y="150" width="18" height="42" fill="#8a8a8a"/></svg>',
  'vltava-graf.svg',
  'Sloupcový graf odchylek výšky hladiny Vltavy od normálu pro 21 dní; údaj ze 14. dne není uveden.',
  'Výška hladiny Vltavy (odchylka od normálu v cm)',
  new List<String>{'Splavná je od $135$ cm, tj. při odchylce aspoň $+15$ cm. To platí ve dnech $10.$, $11.$, $12.$, $13.$, $14.$ (odchylka $+45$) a $15.$, celkem $6$ dnů z $21$.','14.1 $6$ z $21$ dnů je $\\frac{6}{21}\\approx 28{,}6\\,\\%$, což není méně než $23\\,\\%$, tvrzení je nepravdivé (N).','14.2 Za den je na řece nejvýše $50\\cdot 3+10\\cdot 6=210$ lidí, za $6$ splavných dnů nejvýše $6\\cdot 210=1\\,260$ lidí, tvrzení je pravdivé (A).','14.3 Rafty pojmou nejvýše $60$ lidí; při dostatečně malém počtu kajakářů mohou rafťáci tvořit aspoň $30\\,\\%$ (např. $60$ z $200$ vodáků), tvrzení je pravdivé (A).'},
  '14.1: N; 14.2: A; 14.3: A',
  3, 6, '4',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
