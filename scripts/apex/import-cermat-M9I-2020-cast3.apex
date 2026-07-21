String SRC   = 'CERMAT – Ilustrační test 2020, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2020 M9I · úloha 10',
  new List<String>{'V rovině leží tři různé body $A$, $B$ a $O$ (viz obrázek).','Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$. Bod $O$ je průsečík výšek tohoto trojúhelníku.','10.1 Sestrojte a označte písmenem $p$ přímku, na níž leží výška na stranu $AB$.','10.2 Sestrojte vrchol $C$ trojúhelníku $ABC$, označte jej písmenem a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 228 140"><path d="M4 115L10 121M4 121L10 115M103 4L109 10M103 10L109 4M212 58L218 64M212 64L218 58" style="fill:none;stroke:#000000;stroke-width:2"/><text x="8" y="134" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="104" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">O</text><text x="218" y="78" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text></svg>',
  'obr.svg',
  'Tři body v rovině: A vlevo dole, B vpravo uprostřed, O nahoře uprostřed.',
  '',
  new List<String>{'10.1: výška na stranu $AB$ je kolmá k $AB$ a prochází průsečíkem výšek $O$. Přímka $p$ je proto kolmice k přímce $AB$ vedená bodem $O$.','10.2: vrchol $C$ leží na přímce $p$. Navíc platí $AC\\perp BO$ a $BC\\perp AO$. Sestrojíme kolmici k přímce $BO$ vedenou bodem $A$; její průsečík s přímkou $p$ je hledaný vrchol $C$.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  '$p$ je kolmice k $AB$ vedená bodem $O$; vrchol $C$ je průsečík přímky $p$ s kolmicí k $BO$ vedenou bodem $A$ (nákresové řešení).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani'},
  'M9PID20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
