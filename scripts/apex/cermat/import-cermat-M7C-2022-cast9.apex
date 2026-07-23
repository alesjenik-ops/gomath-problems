String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD22C0T03';
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
  'CERMAT M7C 2022 – úloha 16',
  new List<String>{'Výsledný obrazec vytvoříme takto: (1) Na vodorovné přímce sestrojíme několik stejně vzdálených bodů (černých puntíků). (2) Prvním černým puntíkem vedeme dvě různoběžné šikmé přímky; druhým a každým dalším černým puntíkem vedeme rovnoběžky s oběma těmito přímkami. (3) Všechny nově vzniklé průsečíky označíme černými puntíky a těmi vedeme vodorovné přímky. (4) Na spodní vodorovné přímce označíme všechny nově vzniklé průsečíky bílými puntíky.','16.1 Výsledný obrazec obsahuje celkem $36$ černých puntíků. Určete počet všech vodorovných přímek v tomto obrazci.','16.2 Výsledný obrazec obsahuje celkem $49$ vodorovných přímek. Určete počet bílých puntíků na spodní vodorovné přímce tohoto obrazce.','16.3 Výsledný obrazec má na spodní vodorovné přímce celkem $64$ bílých puntíků. Určete počet všech černých puntíků v tomto obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif"><line x1="94" y1="72" x2="250" y2="228" stroke="#000"/><line x1="146" y1="72" x2="302" y2="228" stroke="#000"/><line x1="198" y1="72" x2="354" y2="228" stroke="#000"/><line x1="250" y1="72" x2="406" y2="228" stroke="#000"/><line x1="250" y1="72" x2="94" y2="228" stroke="#000"/><line x1="302" y1="72" x2="146" y2="228" stroke="#000"/><line x1="354" y1="72" x2="198" y2="228" stroke="#000"/><line x1="406" y1="72" x2="250" y2="228" stroke="#000"/><line x1="94" y1="72" x2="406" y2="72" stroke="#000"/><line x1="120" y1="98" x2="380" y2="98" stroke="#000"/><line x1="146" y1="124" x2="354" y2="124" stroke="#000"/><line x1="172" y1="150" x2="328" y2="150" stroke="#000"/><line x1="146" y1="176" x2="354" y2="176" stroke="#000"/><line x1="120" y1="202" x2="380" y2="202" stroke="#000"/><line x1="94" y1="228" x2="406" y2="228" stroke="#000"/><circle cx="172" cy="150" r="3.4" fill="#000"/><circle cx="198" cy="176" r="3.4" fill="#000"/><circle cx="224" cy="202" r="3.4" fill="#000"/><circle cx="250" cy="228" r="3.4" fill="#000"/><circle cx="198" cy="124" r="3.4" fill="#000"/><circle cx="224" cy="150" r="3.4" fill="#000"/><circle cx="250" cy="176" r="3.4" fill="#000"/><circle cx="276" cy="202" r="3.4" fill="#000"/><circle cx="224" cy="98" r="3.4" fill="#000"/><circle cx="250" cy="124" r="3.4" fill="#000"/><circle cx="276" cy="150" r="3.4" fill="#000"/><circle cx="302" cy="176" r="3.4" fill="#000"/><circle cx="250" cy="72" r="3.4" fill="#000"/><circle cx="276" cy="98" r="3.4" fill="#000"/><circle cx="302" cy="124" r="3.4" fill="#000"/><circle cx="328" cy="150" r="3.4" fill="#000"/><circle cx="94" cy="228" r="3.6" fill="#fff" stroke="#000" stroke-width="1.4"/><circle cx="146" cy="228" r="3.6" fill="#fff" stroke="#000" stroke-width="1.4"/><circle cx="198" cy="228" r="3.6" fill="#fff" stroke="#000" stroke-width="1.4"/><circle cx="302" cy="228" r="3.6" fill="#fff" stroke="#000" stroke-width="1.4"/><circle cx="354" cy="228" r="3.6" fill="#fff" stroke="#000" stroke-width="1.4"/><circle cx="406" cy="228" r="3.6" fill="#fff" stroke="#000" stroke-width="1.4"/><text x="250" y="325" font-size="11" text-anchor="middle" fill="#555">schéma výsledného obrazce (černé průsečíky, bílé puntíky na spodní přímce)</text></svg>',
  'obrazec-puntiky.svg',
  'Schéma výsledného obrazce: dvě rodiny šikmých rovnoběžek a vodorovné přímky, černé puntíky v průsečících a bílé puntíky na spodní přímce.',
  'Schematický nákres výsledného obrazce',
  new List<String>{'Je-li na horní přímce $m$ výchozích bodů, vznikne $m^2$ černých puntíků, $2m-1$ vodorovných přímek a $2m-2$ bílých puntíků na spodní přímce.','16.1 $m^2=36\\Rightarrow m=6$; vodorovných přímek $2\\cdot 6-1=11$.','16.2 $2m-1=49\\Rightarrow m=25$; bílých puntíků $2\\cdot 25-2=48$.','16.3 $2m-2=64\\Rightarrow m=33$; černých puntíků $33^2=1\\,089$.'},
  '16.1: $11$ vodorovných přímek; 16.2: $48$ bílých puntíků; 16.3: $1\\,089$ černých puntíků',
  4, 6, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
