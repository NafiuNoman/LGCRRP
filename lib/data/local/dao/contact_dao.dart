import 'package:com.lged.lgcrrp.misulgi/data/remote/model/contact_super_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class ContactDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertContact(ContactModel contactEntity);

  @Query("select * from contact")
  Future<ContactModel?> getAllContacts();

  @Query('delete from contact')
  Future<void> clearContactTable();


}
